import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_chat/src/blocs/chat_cubit.dart';
import 'package:pocket_chat/src/ui/screens/chat_screen.dart';
import 'package:pocket_chat/src/ui/widgets/custom_app_bar.dart';
import 'package:pocket_chat/src/ui/widgets/drawer_item.dart';
import 'package:pocket_chat/src/ui/widgets/chat_history_item.dart';
import 'package:pocket_chat/src/ui/widgets/app_drawer.dart';

import '../../models/session.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int? _selectedSessionId;
  @override
  void initState() {
    super.initState();
  }

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
      drawer: AppDrawer(onHistoryClick: (Session s) {
        setState(() {
          _selectedSessionId = s.id;
        });
        print("_selectedSessionId:$_selectedSessionId");
        Navigator.of(context).pop();
      }, onNewChatClick: () {
        setState(() {
          _selectedSessionId = null;
        });
      },),
      body: ChatScreen(sessionId: _selectedSessionId),
    );
  }
}
