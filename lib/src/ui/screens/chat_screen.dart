import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_chat/src/blocs/chat_cubit.dart';
import 'package:pocket_chat/src/models/message.dart';
import 'package:pocket_chat/src/ui/widgets/message_bubble.dart';
import 'package:pocket_chat/src/ui/widgets/chat_input_field.dart';
import 'package:pocket_chat/src/ui/widgets/welcome_screen.dart';
import 'package:pocket_chat/src/ui/widgets/quick_actions.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late int sessionId = -1;

  @override
  void initState() {
    super.initState();
    // Load messages when the screen is initialized
    context.read<ChatCubit>().loadMessages();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() async{
    if (_textController.text.trim().isNotEmpty) {
      if (sessionId == -1) {
        sessionId = await context.read<ChatCubit>().newSession(_textController.text);
      }
      context.read<ChatCubit>().sendMessage(_textController.text,sessionId,isWebSearch: true);
      _textController.clear();

      // Scroll to bottom after sending a message
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatLoaded) {
                  return _buildMessageList(state.messages);
                } else if (state is ChatError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return _buildWelcomeScreen();
                }
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildWelcomeScreen() {
    return WelcomeScreen(
      onNewChat: () {
        // Clear any existing messages to start a new chat
        context.read<ChatCubit>().clearMessages();
      },
    );
  }

  Widget _buildMessageList(List<Message> messages) {
    if (messages.isEmpty) {
      return _buildWelcomeScreen();
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return _buildMessageBubble(message);
      },
    );
  }

  Widget _buildMessageBubble(Message message) {
    return MessageBubble(
      message: message.contentParts,
      sender: message.role == MessageRoleEnum.user ? 'You' : 'AI Assistant',
      isMe:message.role == MessageRoleEnum.user,
      timestamp: message.timestamp,
    );
  }

  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildInputArea() {
    return ChatInputField(
      controller: _textController,
      onSend: (message) {
        _sendMessage();
      },
      onAttachmentPressed: _showAttachmentOptions,
      onVoicePressed: () {
        // TODO: Implement voice input
      },
    );
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add attachment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildAttachmentOption(Icons.camera_alt, 'Camera'),
                  _buildAttachmentOption(Icons.image, 'Gallery'),
                  _buildAttachmentOption(Icons.file_present, 'Document'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAttachmentOption(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(icon, color: Colors.blue),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }

  void _showQuickActions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Quick Actions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: QuickActions(
                  actions: [
                    QuickActionItem(
                      icon: Icons.lightbulb,
                      title: 'Explain',
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: Implement explain functionality
                      },
                    ),
                    QuickActionItem(
                      icon: Icons.translate,
                      title: 'Translate',
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: Implement translate functionality
                      },
                    ),
                    QuickActionItem(
                      icon: Icons.summarize,
                      title: 'Summarize',
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: Implement summarize functionality
                      },
                    ),
                    QuickActionItem(
                      icon: Icons.question_mark,
                      title: 'Question',
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: Implement question functionality
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
