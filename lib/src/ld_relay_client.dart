import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:ld_relay_client/src/ld_relay_config.dart';
import 'package:ld_relay_client/src/ld_value.dart';
import 'package:logger/logger.dart';

part 'ld_relay_client.freezed.dart';
part 'ld_relay_client.g.dart';

/// Main entry point for LaunchDarkly Relay Proxy client
class LDRelayClient {
  final LDRelayConfig _config;
  final http.Client _httpClient;
  final Logger _logger;

  /// constructor
  LDRelayClient(this._config, this._httpClient, this._logger);

  /// Returns the value of flag [flagKey] for the current context as a bool.
  ///
  /// Will return the provided [defaultValue] if the flag is missing, not a bool, or if some error occurs.
  Future<bool> boolVariation(LaunchDarklyFlagKey flagKey, bool defaultValue,
      LaunchDarklyContext context) async {
    try {
      final response = await _evalWithContext(context);
      return response[flagKey]?.value as bool;
    } catch (e) {
      _logger.w('Error evaluating flag $flagKey: $e');
      return defaultValue;
    }
  }

  /// Returns the value of flag [flagKey] for the current context as an int.
  ///
  /// Will return the provided [defaultValue] if the flag is missing, not a number, or if some error occurs.
  Future<int> intVariation(
      String flagKey, int defaultValue, LaunchDarklyContext context) async {
    try {
      final response = await _evalWithContext(context);
      return response[flagKey]?.value as int;
    } catch (e) {
      _logger.w('Error evaluating flag $flagKey: $e');
      return defaultValue;
    }
  }

  /// Returns the value of flag [flagKey] for the current context as a double.
  ///
  /// Will return the provided [defaultValue] if the flag is missing, not a number, or if some error occurs.
  Future<double> doubleVariation(
      String flagKey, double defaultValue, LaunchDarklyContext context) async {
    try {
      final response = await _evalWithContext(context);
      return response[flagKey]?.value as double;
    } catch (e) {
      _logger.w('Error evaluating flag $flagKey: $e');
      return defaultValue;
    }
  }

  /// Returns the value of flag [flagKey] for the current context as a string.
  ///
  /// Will return the provided [defaultValue] if the flag is missing, not a string, or if some error occurs.
  Future<String> stringVariation(
      String flagKey, String defaultValue, LaunchDarklyContext context) async {
    try {
      final response = await _evalWithContext(context);
      return response[flagKey]?.value as String;
    } catch (e) {
      _logger.w('Error evaluating flag $flagKey: $e');
      return defaultValue;
    }
  }

  /// Returns the value of flag [flagKey] for the current context as an [LDValue].
  ///
  /// Will return the provided [defaultValue] if the flag is missing, or if some error occurs.
  Future<LDValue> jsonVariation(
      String flagKey, LDValue defaultValue, LaunchDarklyContext context) async {
    try {
      final response = await _evalWithContext(context);
      return LDValue.fromCodecValue(response[flagKey]?.value);
    } catch (e) {
      _logger.w('Error evaluating flag $flagKey: $e');
      return defaultValue.codecValue();
    }
  }

  Future<LaunchDarklyResponse> _evalWithContext(
    LaunchDarklyContext context, {
    retryCount = 3,
  }) async {
    /// {contextBase64} means the JSON representation of an evaluation context converted to base64 encoding.
    /// see: https://github.com/launchdarkly/ld-relay/blob/v7/docs/endpoints.md#notes-on-requestpath-parameters
    final contextBase64 = _base64url(utf8.encode(jsonEncode(context.toJson())));
    final retryClient = RetryClient(
      _httpClient,
      retries: retryCount,
      onRetry: (req, res, count) => _logger.w(
          'ld-relay is temporarily Unavailable. retryCount: $count/$retryCount'),
    );

    final response = await retryClient.get(
      Uri.parse('${_config.ldRelayBaseUrl}/sdk/evalx/contexts/$contextBase64'),
      headers: {
        'Authorization': _config.sdkKey,
      },
    );
    if (response.statusCode != 200) {
      throw Exception(
          'An unexpected error occurred in calling evalx endpoint: ${response.statusCode} ${response.body}');
    }

    final responseBody = json.decode(response.body) as Map<String, dynamic>;
    return responseBody.map(
        (key, value) => MapEntry(key, LaunchDarklyEvalResult.fromJson(value)));
  }

  String _base64url(List<int> bytes) {
    return base64Url.encode(bytes).replaceAll('=', '');
  }
}

/// LaunchDarkly Context
typedef LaunchDarklyContext
    = Map<LaunchDarklyContextKind, LaunchDarklyContextAttribute>;

/// extension for LaunchDarklyContext
extension LaunchDarklyContextExt on LaunchDarklyContext {
  /// toJson
  Map<String, dynamic> toJson() {
    late final Map<String, dynamic> contextJson;
    switch (length) {
      case 0:
        throw Exception('LaunchDarkly context must not be empty');
      case 1:
        contextJson = {
          'kind': entries.first.key,
          'key': entries.first.value.key,
        };
      default:
        contextJson = {
          'kind': 'multi',
        };
        forEach((key, value) {
          contextJson[key] = value.toJson();
        });
    }
    return contextJson;
  }
}

/// LaunchDarkly Context kind
///
/// see: https://docs.launchdarkly.com/home/contexts/context-kinds
typedef LaunchDarklyContextKind = String;

/// LaunchDarkly Context attribute
///
/// see: https://docs.launchdarkly.com/home/contexts/attributes
@Freezed(copyWith: false)
class LaunchDarklyContextAttribute with _$LaunchDarklyContextAttribute {
  /// internal constructor
  const factory LaunchDarklyContextAttribute._internal({
    required String key,
  }) = _LaunchDarklyContextAttribute;

  /// constructor
  factory LaunchDarklyContextAttribute({
    /// a unique string identifying a context.
    required String key,
  }) {
    if (key.isEmpty) {
      throw Exception('LaunchDarklyContextAttribute key must not be empty');
    }
    return LaunchDarklyContextAttribute._internal(key: key);
  }

  /// fromJson
  factory LaunchDarklyContextAttribute.fromJson(Map<String, dynamic> json) =>
      _$LaunchDarklyContextAttributeFromJson(json);
}

/// Response from LaunchDarkly (Relay Proxy)
typedef LaunchDarklyResponse = Map<LaunchDarklyFlagKey, LaunchDarklyEvalResult>;

/// the key of Feature flag
typedef LaunchDarklyFlagKey = String;

/// Result of flag evaluation
@Freezed(copyWith: false)
class LaunchDarklyEvalResult with _$LaunchDarklyEvalResult {
  /// constructor
  const factory LaunchDarklyEvalResult({
    /// the value of the flag
    required dynamic value,

    /// the variation of the flag value
    required int variation,

    /// the version of the flag value
    required int version,
  }) = _LaunchDarklyEvalResult;

  /// fromJson
  factory LaunchDarklyEvalResult.fromJson(Map<String, dynamic> json) =>
      _$LaunchDarklyEvalResultFromJson(json);
}
