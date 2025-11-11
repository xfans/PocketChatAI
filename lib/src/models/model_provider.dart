import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_provider.freezed.dart';
part 'model_provider.g.dart';

@freezed
abstract class ModelProvider with _$ModelProvider {
  const factory ModelProvider({
    required String id,
    required String name,
    required String type,
    String? website,
    String? apiKey,
    String? apiHost,
    String? apiPath,
    String? endpoint,
    String? apiVersion,
    required List<ModelInfo> models,
  }) = _ModelProvider;

  factory ModelProvider.fromJson(Map<String, dynamic> json) =>
      _$ModelProviderFromJson(json);

  static empty() {
    return const ModelProvider(
      id: '',
      name: '',
      type: '',
      models: [],
    );
  }
}

@freezed
abstract class ModelInfo with _$ModelInfo {
  const factory ModelInfo({
    required String modelId,
    String? type,
    String? nickname,
    required List<String> capabilities,
    int? contextWindow,
    int? maxOutput,
  }) = _ModelInfo;

  factory ModelInfo.fromJson(Map<String, dynamic> json) =>
      _$ModelInfoFromJson(json);
}
