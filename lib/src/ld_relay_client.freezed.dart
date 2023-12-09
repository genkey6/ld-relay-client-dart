// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ld_relay_client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LaunchDarklyContextAttribute _$LaunchDarklyContextAttributeFromJson(
    Map<String, dynamic> json) {
  return _LaunchDarklyContextAttribute.fromJson(json);
}

/// @nodoc
mixin _$LaunchDarklyContextAttribute {
  String get key => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$LaunchDarklyContextAttributeImpl
    implements _LaunchDarklyContextAttribute {
  const _$LaunchDarklyContextAttributeImpl({required this.key});

  factory _$LaunchDarklyContextAttributeImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$LaunchDarklyContextAttributeImplFromJson(json);

  @override
  final String key;

  @override
  String toString() {
    return 'LaunchDarklyContextAttribute._internal(key: $key)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LaunchDarklyContextAttributeImpl &&
            (identical(other.key, key) || other.key == key));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, key);

  @override
  Map<String, dynamic> toJson() {
    return _$$LaunchDarklyContextAttributeImplToJson(
      this,
    );
  }
}

abstract class _LaunchDarklyContextAttribute
    implements LaunchDarklyContextAttribute {
  const factory _LaunchDarklyContextAttribute({required final String key}) =
      _$LaunchDarklyContextAttributeImpl;

  factory _LaunchDarklyContextAttribute.fromJson(Map<String, dynamic> json) =
      _$LaunchDarklyContextAttributeImpl.fromJson;

  @override
  String get key;
}

LaunchDarklyEvalResult _$LaunchDarklyEvalResultFromJson(
    Map<String, dynamic> json) {
  return _LaunchDarklyEvalResult.fromJson(json);
}

/// @nodoc
mixin _$LaunchDarklyEvalResult {
  /// the value of the flag
  dynamic get value => throw _privateConstructorUsedError;

  /// the variation of the flag value
  int get variation => throw _privateConstructorUsedError;

  /// the version of the flag value
  int get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$LaunchDarklyEvalResultImpl implements _LaunchDarklyEvalResult {
  const _$LaunchDarklyEvalResultImpl(
      {required this.value, required this.variation, required this.version});

  factory _$LaunchDarklyEvalResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$LaunchDarklyEvalResultImplFromJson(json);

  /// the value of the flag
  @override
  final dynamic value;

  /// the variation of the flag value
  @override
  final int variation;

  /// the version of the flag value
  @override
  final int version;

  @override
  String toString() {
    return 'LaunchDarklyEvalResult(value: $value, variation: $variation, version: $version)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LaunchDarklyEvalResultImpl &&
            const DeepCollectionEquality().equals(other.value, value) &&
            (identical(other.variation, variation) ||
                other.variation == variation) &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(value), variation, version);

  @override
  Map<String, dynamic> toJson() {
    return _$$LaunchDarklyEvalResultImplToJson(
      this,
    );
  }
}

abstract class _LaunchDarklyEvalResult implements LaunchDarklyEvalResult {
  const factory _LaunchDarklyEvalResult(
      {required final dynamic value,
      required final int variation,
      required final int version}) = _$LaunchDarklyEvalResultImpl;

  factory _LaunchDarklyEvalResult.fromJson(Map<String, dynamic> json) =
      _$LaunchDarklyEvalResultImpl.fromJson;

  @override

  /// the value of the flag
  dynamic get value;
  @override

  /// the variation of the flag value
  int get variation;
  @override

  /// the version of the flag value
  int get version;
}
