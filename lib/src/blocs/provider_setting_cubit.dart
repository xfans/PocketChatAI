import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocket_chat/src/models/model_provider.dart';
import 'package:pocket_chat/src/services/provider_service.dart';

part 'provider_setting_state.dart';

class ProviderSettingCubit extends Cubit<ProviderSettingLoaded> {
  // In-memory cache of all providers
  List<ModelProvider> _settingProviders = [];

  //default providers map
  Map<String, ModelProvider> _defaultProviders = {};
  bool _isLoaded = false;

  ProviderSettingCubit() : super(ProviderSettingLoaded());

  /// Initialize the cubit by loading all settings from file
  Future<void> initialize() async {
    if (_isLoaded) return;

    try {
      await _loadAllSettingsFromFile();
      final defaultProvidersList = ProviderService.getDefaultProviders();
      _defaultProviders = {for (var p in defaultProvidersList) p.id: p};
      _isLoaded = true;
    } catch (e) {
      _isLoaded = false;
    }
  }

  Future<void> checkingApiKey() async {
    emit(ProviderSettingLoaded(isCheckingApiKey: true));
    Future.delayed(Duration(seconds: 2), () {
      print('2秒后执行');
      emit(ProviderSettingLoaded(isApiKeyValid: true));
    });
  }

  Future<void> loadProviderList() async {
    try {
      if (!_isLoaded) await initialize();
      // Create a map from setting providers for quick lookup
      final settingMap = {for (var p in _settingProviders) p.id: p};

      // Start with default providers, replacing with setting providers where IDs match
      final mergedProviders =
          _defaultProviders.values.map((p) => settingMap[p.id] ?? p).toList();

      // Add setting providers that don't exist in defaults
      final extraProviders = _settingProviders
          .where((p) => !_defaultProviders.containsKey(p.id))
          .toList();

      mergedProviders.addAll(extraProviders);

      emit(ProviderSettingLoaded(providers: mergedProviders));
    } catch (e) {
      emit(ProviderSettingLoaded());
    }
  }

  /// Load settings for a specific provider (from cache or file)
  Future<void> loadProvider(String providerId) async {
    try {
      // Check if provider is in cache
      final existingProvider = _settingProviders.firstWhere(
        (provider) => provider.id == providerId,
        orElse: () => ModelProvider(
          id: '',
          name: '',
          type: '',
          models: [],
        ),
      );

      if (existingProvider.id.isNotEmpty) {
        emit(ProviderSettingLoaded(provider: existingProvider));
        return;
      } else {
        final provider = _defaultProviders[providerId];
        if (provider != null) {
          emit(ProviderSettingLoaded(provider: provider));
        } else {
          emit(ProviderSettingLoaded());
        }
      }
    } catch (e) {
      emit(ProviderSettingLoaded());
    }
  }

  /// Save settings for a specific provider to cache and file
  Future<void> saveProviderSettings(
      String providerId, ModelProvider provider) async {
    try {
      // Update cache
      // Find if provider with same id already exists
      final existingIndex =
          _settingProviders.indexWhere((p) => p.id == providerId);
      if (existingIndex >= 0) {
        // Replace existing provider
        _settingProviders[existingIndex] = provider;
      } else {
        // Add new provider
        _settingProviders.add(provider);
      }

      // Save to file
      await _saveAllSettingsToFile();

      emit(ProviderSettingLoaded(provider: provider));
    } catch (e) {
      emit(ProviderSettingLoaded());
    }
  }

  /// Private method to load all settings from JSON file
  Future<void> _loadAllSettingsFromFile() async {
    final file = await _getSettingsFile();

    if (await file.exists()) {
      final jsonString = await file.readAsString();
      if (jsonString.isNotEmpty) {
        final List<dynamic> jsonList = jsonDecode(jsonString);
        _settingProviders = jsonList
            .map((item) => ModelProvider.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    }

    _isLoaded = true;
  }

  /// Private method to save all settings to JSON file
  Future<void> _saveAllSettingsToFile() async {
    final file = await _getSettingsFile();

    // Convert cache to list
    final jsonString = jsonEncode(_settingProviders);
    await file.writeAsString(jsonString);
  }

  /// Private method to get the settings file path
  Future<File> _getSettingsFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/provider_settings.json';
    return File(filePath);
  }
}
