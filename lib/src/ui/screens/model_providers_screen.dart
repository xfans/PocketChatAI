import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_chat/src/ui/widgets/custom_app_bar.dart';
import 'package:pocket_chat/src/services/provider_service.dart';
import 'package:pocket_chat/src/models/model_provider.dart';

class ModelProvidersScreen extends StatefulWidget {
  const ModelProvidersScreen({super.key});

  @override
  State<ModelProvidersScreen> createState() => _ModelProvidersScreenState();
}

class _ModelProvidersScreenState extends State<ModelProvidersScreen> {
  late Future<void> _providersFuture;

  @override
  void initState() {
    super.initState();
    _providersFuture = ProviderService().loadProviders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Model Providers',
        onMenuPressed: () {
          context.pop();
        },
      ),
      body: FutureBuilder<void>(
        future: _providersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final providers = ProviderService().providers;

          return ListView.builder(
            itemCount: providers.length,
            itemBuilder: (context, index) {
              final provider = providers[index];
              return ListTile(
                leading: const Icon(Icons.cloud),
                title: Text(provider.name),
                subtitle: Text(provider.type),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  context.pushNamed('modelSettings', pathParameters: {
                    'providerId': provider.id,
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
