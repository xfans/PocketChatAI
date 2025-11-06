import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_chat/src/ui/widgets/custom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
        onMenuPressed: () {
          context.pop();
        },
      ),
      body: const Center(
        child: Text('Settings Screen'),
      ),
    );
  }
}
