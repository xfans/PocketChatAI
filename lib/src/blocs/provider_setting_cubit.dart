import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocket_chat/src/blocs/provider_setting_state.dart';
import 'package:pocket_chat/src/models/model_provider.dart';
import 'package:pocket_chat/src/services/provider_service.dart';

class ProviderSettingCubit extends Cubit<ProviderSettingState> {
  // In-memory cache of all providers
  List<ModelProvider> _settingProviders = [];

  //default providers map
  Map<String, ModelProvider> _defaultProviders = {};
  bool _isLoaded = false;

  ProviderSettingCubit() : super(ProviderSettingState());

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

  Future<void> checkingApiKey(String providerId,String apiKey) async {
    emit(state.copyWith(isCheckingApiKey:  true));
    Future.delayed(Duration(seconds: 1), () async {
      print('2秒后执行');
      saveProviderSettings(providerId,apiKey: apiKey);
      emit(state.copyWith(isCheckingApiKey:  false));
      emit(state.copyWith(isApiKeyValid:  true));
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

      emit(state.copyWith(providers: mergedProviders));
    } catch (e) {
      emit(state.copyWith(providers: null));
    }
  }

  /// Load settings for a specific provider (from cache or file)
  Future<void> loadProvider(String providerId) async {
    try {
      // Check if provider is in cache
      final existingProvider = _settingProviders.firstWhere(
        (provider) => provider.id == providerId,
        orElse: () => const ModelProvider(
          id: '',
          name: '',
          type: '',
          models: [],
        ),
      );

      if (existingProvider.id.isNotEmpty) {
        print("loadProvider setting Provider: $existingProvider");
        emit(state.copyWith(provider: existingProvider));
        return;
      } else {
        final provider = _defaultProviders[providerId];
        print("loadProvider default Provider: $provider");
        if (provider != null) {
          emit(state.copyWith(provider: provider));
        } else {
          emit(state.copyWith(provider: null));
        }
      }
    } catch (e) {
      emit(state.copyWith(provider: null));
    }
  }

  /// Save settings for a specific provider to cache and file
  Future<void> saveProviderSettings(
      String providerId, {
        String? apiKey,
        String? apiHost,
      }) async {
    try {
      final existingIndex =
          _settingProviders.indexWhere((p) => p.id == providerId);
      ModelProvider? provider;
      if (existingIndex >= 0) {
        print('_settingProviders');
        provider = _settingProviders[existingIndex];
        if (apiKey != null) {
          provider = provider.copyWith(apiKey: apiKey);
        }
        if (apiHost != null) {
          provider = provider.copyWith(apiHost: apiHost);
        }
        _settingProviders[existingIndex] = provider;
      }else{
        print('_defaultProviders');
        provider = _defaultProviders[providerId];
        if (provider != null) {
          if (apiKey != null) {
            provider = provider.copyWith(apiKey: apiKey);
          }
          if (apiHost != null) {
            provider = provider.copyWith(apiHost: apiHost);
          }
          _settingProviders.add(provider);
        }
      }
      if (provider != null) {
        print(_settingProviders.toString());
        // Save to file
        await _saveAllSettingsToFile();
        emit(state.copyWith(provider: provider));
      }


    } catch (e) {
      emit(state.copyWith(provider: null));
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
