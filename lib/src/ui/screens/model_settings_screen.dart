import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_chat/src/ui/widgets/custom_app_bar.dart';
import 'package:pocket_chat/src/ui/widgets/custom_text_field.dart';
import 'package:pocket_chat/src/ui/widgets/custom_button.dart';
import 'package:pocket_chat/src/services/provider_service.dart';
import 'package:pocket_chat/src/models/model_provider.dart';
import 'package:pocket_chat/src/blocs/provider_setting_cubit.dart';

class ModelSettingsScreen extends StatefulWidget {
  final String providerId;

  const ModelSettingsScreen({super.key, required this.providerId});

  @override
  State<ModelSettingsScreen> createState() => _ModelSettingsScreenState();
}

class _ModelSettingsScreenState extends State<ModelSettingsScreen> {
  late TextEditingController _apiKeyController;
  late TextEditingController _apiHostController;


  @override
  void initState() {
    super.initState();
    _apiKeyController = TextEditingController();
    _apiHostController = TextEditingController();

    context.read<ProviderSettingCubit>().loadProvider(widget.providerId);
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    _apiHostController.dispose();
    super.dispose();
  }

  void _saveSettings(ModelProvider _provider) {
    if (_provider != null) {
      final cubit = context.read<ProviderSettingCubit>();
      // Create an updated provider with the new settings
      final updatedProvider = ModelProvider(
        id: _provider!.id,
        name: _provider!.name,
        type: _provider!.type,
        website: _provider!.website,
        apiHost: _apiHostController.text,
        apiPath: _provider!.apiPath,
        endpoint: _provider!.endpoint,
        apiVersion: _provider!.apiVersion,
        models: _provider!.models,
      );
      cubit.saveProviderSettings(widget.providerId, updatedProvider);
    }
  }

  void _validateApiKey(ModelProvider _provider) async {

    // Simulate API key validation
    await Future.delayed(const Duration(seconds: 1));

    // In a real implementation, you would call your API service to validate the key
    bool isValid = _apiKeyController.text.isNotEmpty;

    // Save settings if API key is valid
    if (isValid) {
      _saveSettings(_provider);
    }
  }

  void _addNewModel() {
    // In a real implementation, this would open a model editor dialog
    // For now, we'll show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Add new model functionality would go here')),
    );
  }

  void _editModel(ModelInfo model) {
    // In a real implementation, this would open a model editor dialog
    // For now, we'll show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit model: ${model.nickname ?? model.modelId}')),
    );
  }

  void _deleteModel(ModelInfo model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Model'),
          content: Text(
              'Are you sure you want to delete ${model.nickname ?? model.modelId}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // In a real implementation, this would remove the model from the provider
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Deleted model: ${model.nickname ?? model.modelId}')),
                );
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _resetModels() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset Models'),
          content: const Text(
              'Are you sure you want to reset all models to default?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // In a real implementation, this would reset models to default
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Models reset to default')),
                );
              },
              child: const Text('Reset', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProviderSettingCubit, ProviderSettingLoaded>(
      builder: (context, state) {
        if (state.provider == null) {
          return Scaffold(
            appBar: CustomAppBar(
              title: 'Provider Not Found',
              onBackPressed: () {
                context.pop();
              },
            ),
            body: const Center(
              child: Text('Provider not found'),
            ),
          );
        }
        _apiHostController.text = state.provider!.apiHost!;
        return Scaffold(
          appBar: CustomAppBar(
            title: '${state.provider!.name} Settings',
            onBackPressed: () {
              context.pop();
            },
            actions: [

            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // API Key Section
                const Text(
                  'API Key',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _apiKeyController,
                  hintText: 'Enter your API key',
                  obscureText: true,
                  suffixIcon: state.isCheckingApiKey
                      ? const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : state.isApiKeyValid
                          ? const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Icon(Icons.check, color: Colors.green),
                            )
                          : null,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    CustomButton(
                      text: 'Check',
                      onPressed: _apiKeyController.text.isEmpty
                          ? null
                          : (){
                        _validateApiKey(state.provider!);
                      },
                    ),
                    const SizedBox(width: 12),

                  ],
                ),
                const SizedBox(height: 16),

                // API Host Section
                const Text(
                  'API Host',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: _apiHostController,
                  hintText: 'Enter API host URL',
                  onChanged: (value) {
                    // Save settings when API host changes
                    _saveSettings(state.provider!);
                  },
                ),
                const SizedBox(height: 24),

                // Models Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Models',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _addNewModel,
                          tooltip: 'Add Model',
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (state.provider!.models.isNotEmpty) ...[
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.provider!.models.length,
                      itemBuilder: (context, index) {
                        final model = state.provider!.models[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            title: Text(model.nickname ?? model.modelId),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ID: ${model.modelId}'),
                                if (model.contextWindow != null)
                                  Text(
                                      'Context: ${model.contextWindow} tokens'),
                                if (model.capabilities.isNotEmpty)
                                  Text(
                                      'Capabilities: ${model.capabilities.join(', ')}'),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, size: 18),
                                  onPressed: () => _editModel(model),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, size: 18),
                                  onPressed: () => _deleteModel(model),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ] else
                  const Text('No models available for this provider'),
              ],
            ),
          ),
        );
      },
    );
  }
}
