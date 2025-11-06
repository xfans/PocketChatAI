import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_chat/src/ui/screens/home_screen.dart';
import 'package:pocket_chat/src/ui/screens/settings_screen.dart';
import 'package:pocket_chat/src/ui/screens/about_screen.dart';
import 'package:pocket_chat/src/ui/screens/model_providers_screen.dart';
import 'package:pocket_chat/src/ui/screens/model_settings_screen.dart';
import 'package:pocket_chat/src/models/model_provider.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: '/model-providers',
          name: 'modelProviders',
          builder: (context, state) => const ModelProvidersScreen(),
        ),
        GoRoute(
          path: '/model-settings/:providerId',
          name: 'modelSettings',
          builder: (context, state) {
            final providerId = state.pathParameters['providerId']!;
            return ModelSettingsScreen(providerId: providerId);
          },
        ),
        GoRoute(
          path: '/about',
          name: 'about',
          builder: (context, state) => const AboutScreen(),
        ),
      ],
      errorBuilder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Page not found'),
        ),
      ),
    );
  }
}
