class ModelProvider {
  final String id;
  final String name;
  final String type;
  final String? website;
  final String? apiKey;
  final String? apiHost;
  final String? apiPath;
  final String? endpoint;
  final String? apiVersion;
  final List<ModelInfo> models;

  ModelProvider({
    required this.id,
    required this.name,
    required this.type,
    this.website,
    this.apiKey,
    this.apiHost,
    this.apiPath,
    this.endpoint,
    this.apiVersion,
    required this.models,
  });

  factory ModelProvider.fromJson(Map<String, dynamic> json) {
    List<ModelInfo> models = [];
    if (json['defaultSettings'] != null &&
        json['defaultSettings']['models'] != null) {
      models = (json['defaultSettings']['models'] as List)
          .map((model) => ModelInfo.fromJson(model as Map<String, dynamic>))
          .toList();
    }

    return ModelProvider(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      website: json['urls']?['website'] as String?,
      apiHost: json['defaultSettings']?['apiHost'] as String?,
      apiPath: json['defaultSettings']?['apiPath'] as String?,
      endpoint: json['defaultSettings']?['endpoint'] as String?,
      apiVersion: json['defaultSettings']?['apiVersion'] as String?,
      models: models,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['website'] = website;

    final Map<String, dynamic> defaultSettings = <String, dynamic>{};
    defaultSettings['apiHost'] = apiHost;
    defaultSettings['apiPath'] = apiPath;
    defaultSettings['endpoint'] = endpoint;
    defaultSettings['apiVersion'] = apiVersion;

    final List<Map<String, dynamic>> modelsList =
        models.map((model) => model.toJson()).toList();
    defaultSettings['models'] = modelsList;

    data['defaultSettings'] = defaultSettings;
    return data;
  }
}

class ModelInfo {
  final String modelId;
  final String? type;
  final String? nickname;
  final List<String> capabilities;
  final int? contextWindow;
  final int? maxOutput;

  ModelInfo({
    required this.modelId,
    this.type,
    this.nickname,
    required this.capabilities,
    this.contextWindow,
    this.maxOutput,
  });

  factory ModelInfo.fromJson(Map<String, dynamic> json) {
    List<String> capabilities = [];
    if (json['capabilities'] != null) {
      capabilities =
          (json['capabilities'] as List).map((e) => e as String).toList();
    }

    return ModelInfo(
      modelId: json['modelId'] as String,
      type: json['type'] as String?,
      nickname: json['nickname'] as String?,
      capabilities: capabilities,
      contextWindow: json['contextWindow'] as int?,
      maxOutput: json['maxOutput'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['modelId'] = modelId;
    data['type'] = type;
    data['nickname'] = nickname;

    data['capabilities'] = capabilities;
    data['contextWindow'] = contextWindow;
    data['maxOutput'] = maxOutput;

    return data;
  }
}
