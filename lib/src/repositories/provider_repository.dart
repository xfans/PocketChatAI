import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/model_provider.dart';
import '../services/provider_service.dart';

class ProviderRepository {
  ProviderRepository._();
  static final instance = ProviderRepository._();

  final Map<String, ModelProvider> _defaults = {
    for (final p in ProviderService.getDefaultProviders()) p.id: p
  };

  final List<ModelProvider> _cache = [];

  bool _loaded = false;

  /* ---------- 对外 API ---------- */

  Future<List<ModelProvider>> loadAll() async {
    if (!_loaded) await _readFromFile();
    final settingsMap = {for (final p in _cache) p.id: p};
    return [
      // 先放“默认+用户配置”的合并结果
      ..._defaults.values.map((d) => settingsMap[d.id] ?? d),
      // 再放用户新增的
      ..._cache.where((c) => !_defaults.containsKey(c.id)),
    ];
  }

  Future<ModelProvider?> get(String id) async {
    if (!_loaded) await _readFromFile();
    return _cache.firstWhere((p) => p.id == id,
        orElse: () => _defaults[id] ?? ModelProvider.empty());
  }

  Future<void> save(String id,
      {String? apiKey, String? apiHost}) async {
    if (!_loaded) await _readFromFile();

    final idx = _cache.indexWhere((p) => p.id == id);
    final base = idx >= 0
        ? _cache[idx]
        : _defaults[id] ?? (throw 'Unknown provider=$id');

    final updated = base.copyWith(
      apiKey: apiKey ?? base.apiKey,
      apiHost: apiHost ?? base.apiHost,
    );

    if (idx >= 0) {
      _cache[idx] = updated;
    } else {
      _cache.add(updated);
    }
    return _writeToFile();
  }

  /* ---------- 私有 ---------- */

  Future<File> get _file async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/provider_settings.json');
  }

  Future<void> _readFromFile() async {
    final f = await _file;
    if (await f.exists()) {
      final json = jsonDecode(await f.readAsString()) as List;
      _cache.addAll(
          json.map((e) => ModelProvider.fromJson(e)).cast<ModelProvider>());
    }
    _loaded = true;
  }

  Future<void> _writeToFile() async =>
      (await _file).writeAsString(jsonEncode(_cache));
}