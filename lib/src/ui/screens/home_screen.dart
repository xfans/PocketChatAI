import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_chat/src/blocs/chat_cubit.dart';
import 'package:pocket_chat/src/ui/screens/chat_screen.dart';
import 'package:pocket_chat/src/ui/widgets/custom_app_bar.dart';
import 'package:pocket_chat/src/ui/widgets/drawer_item.dart';
import 'package:pocket_chat/src/ui/widgets/chat_history_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Map<String, String>> _chatHistory = [
    {
      'title': 'Travel Planning',
      'subtitle': 'Suggest places to visit in Japan'
    },
    {'title': 'Recipe Ideas', 'subtitle': 'How to make authentic pasta'},
    {'title': 'Work Project', 'subtitle': 'Help with Flutter app design'},
    {
      'title': 'Learning Python',
      'subtitle': 'Explain object-oriented programming'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'AI ChatBox',
        onMenuPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => context.read<ChatCubit>().clearMessages(),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 30, color: Colors.blue),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'User Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'user@example.com',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerItem(
                    icon: Icons.add,
                    title: 'New Chat',
                    onTap: () {
                      context.read<ChatCubit>().clearMessages();
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
                    child: Text(
                      'HISTORY',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  ..._chatHistory.asMap().entries.map((entry) {
                    Map<String, String> chat = entry.value;
                    return ChatHistoryItem(
                      title: chat['title']!,
                      subtitle: chat['subtitle']!,
                      onTap: () {
                        // TODO: Implement chat history loading
                        Navigator.pop(context);
                      },
                      onLongPress: () {
                        // TODO: Implement chat history context menu
                      },
                    );
                  }).toList(),
                  const Divider(),
                  DrawerItem(
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () {
                      // TODO: Implement settings navigation
                      Navigator.pop(context);
                    },
                  ),
                  DrawerItem(
                    icon: Icons.info,
                    title: 'About',
                    onTap: () {
                      // TODO: Implement about navigation
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement logout functionality
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 40),
                ),
              ),
            ),
          ],
        ),
      ),
      body: const ChatScreen(),
    );
  }
}
