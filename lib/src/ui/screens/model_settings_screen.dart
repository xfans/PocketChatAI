import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_chat/src/ui/widgets/custom_app_bar.dart';
import 'package:pocket_chat/src/ui/widgets/custom_text_field.dart';
import 'package:pocket_chat/src/services/provider_service.dart';
import 'package:pocket_chat/src/models/model_provider.dart';

class ModelSettingsScreen extends StatefulWidget {
  final String providerId;

  const ModelSettingsScreen({super.key, required this.providerId});

  @override
  State<ModelSettingsScreen> createState() => _ModelSettingsScreenState();
}

class _ModelSettingsScreenState extends State<ModelSettingsScreen> {
  late ModelProvider? _provider;
  late TextEditingController _apiKeyController;
  late TextEditingController _apiHostController;
  String? _selectedModel;

  @override
  void initState() {
    super.initState();
    _provider = ProviderService().getProviderById(widget.providerId);
    _apiKeyController = TextEditingController();
    _apiHostController = TextEditingController(text: _provider?.apiHost ?? '');
    if (_provider?.models.isNotEmpty ?? false) {
      _selectedModel = _provider!.models.first.modelId;
    }
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    _apiHostController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_provider == null) {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'Provider Not Found',
          onMenuPressed: () {
            context.pop();
          },
        ),
        body: const Center(
          child: Text('Provider not found'),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: '${_provider!.name} Settings',
        onMenuPressed: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: _apiKeyController,
              hintText: 'Enter your API key',
              obscureText: true,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: _apiHostController,
              hintText: 'Enter API host URL',
            ),
            const SizedBox(height: 24),
            if (_provider!.models.isNotEmpty) ...[
              const Text(
                'Select Model',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: _provider!.models.length,
                  itemBuilder: (context, index) {
                    final model = _provider!.models[index];
                    return Card(
                      child: ListTile(
                        title: Text(model.nickname ?? model.modelId),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ID: ${model.modelId}'),
                            if (model.contextWindow != null)
                              Text('Context: ${model.contextWindow} tokens'),
                            if (model.capabilities.isNotEmpty)
                              Text(
                                  'Capabilities: ${model.capabilities.join(', ')}'),
                          ],
                        ),
                        selected: _selectedModel == model.modelId,
                        onTap: () {
                          setState(() {
                            _selectedModel = model.modelId;
                          });
                        },
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
  }
}
