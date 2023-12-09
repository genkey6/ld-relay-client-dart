// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ld_relay_client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LaunchDarklyContextAttributeImpl _$$LaunchDarklyContextAttributeImplFromJson(
        Map<String, dynamic> json) =>
    _$LaunchDarklyContextAttributeImpl(
      key: json['key'] as String,
    );

Map<String, dynamic> _$$LaunchDarklyContextAttributeImplToJson(
        _$LaunchDarklyContextAttributeImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
    };

_$LaunchDarklyEvalResultImpl _$$LaunchDarklyEvalResultImplFromJson(
        Map<String, dynamic> json) =>
    _$LaunchDarklyEvalResultImpl(
      value: json['value'],
      variation: json['variation'] as int,
      version: json['version'] as int,
    );

Map<String, dynamic> _$$LaunchDarklyEvalResultImplToJson(
        _$LaunchDarklyEvalResultImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'variation': instance.variation,
      'version': instance.version,
    };
