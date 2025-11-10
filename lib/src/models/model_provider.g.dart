// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ModelProvider _$ModelProviderFromJson(Map<String, dynamic> json) =>
    _ModelProvider(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      website: json['website'] as String?,
      apiKey: json['apiKey'] as String?,
      apiHost: json['apiHost'] as String?,
      apiPath: json['apiPath'] as String?,
      endpoint: json['endpoint'] as String?,
      apiVersion: json['apiVersion'] as String?,
      models: (json['models'] as List<dynamic>)
          .map((e) => ModelInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ModelProviderToJson(_ModelProvider instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'website': instance.website,
      'apiKey': instance.apiKey,
      'apiHost': instance.apiHost,
      'apiPath': instance.apiPath,
      'endpoint': instance.endpoint,
      'apiVersion': instance.apiVersion,
      'models': instance.models,
    };

_ModelInfo _$ModelInfoFromJson(Map<String, dynamic> json) => _ModelInfo(
  modelId: json['modelId'] as String,
  type: json['type'] as String?,
  nickname: json['nickname'] as String?,
  capabilities: (json['capabilities'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  contextWindow: (json['contextWindow'] as num?)?.toInt(),
  maxOutput: (json['maxOutput'] as num?)?.toInt(),
);

Map<String, dynamic> _$ModelInfoToJson(_ModelInfo instance) =>
    <String, dynamic>{
      'modelId': instance.modelId,
      'type': instance.type,
      'nickname': instance.nickname,
      'capabilities': instance.capabilities,
      'contextWindow': instance.contextWindow,
      'maxOutput': instance.maxOutput,
    };
