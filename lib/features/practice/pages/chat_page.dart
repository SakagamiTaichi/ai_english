import 'package:ai_english/core/components/footer.dart';
import 'package:ai_english/features/practice/components/message_bubble.dart';
import 'package:ai_english/features/practice/components/reset_alert_dialog.dart';
import 'package:ai_english/features/practice/components/side_menue.dart';
import 'package:ai_english/features/practice/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_english/core/utils/providers/tts_provider.dart';

class ChatPage extends ConsumerWidget {
  ChatPage({super.key});

  final TextEditingController _controller = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _sendMessage(WidgetRef ref) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    ref.read(chatNotifierProvider.notifier).sendMessage(text);
    _controller.clear();
  }

  void _resetChat(WidgetRef ref) {
    showDialog(
      context: ref.context,
      builder: (BuildContext context) {
        return resetAlertDialog(context, () {
          ref.read(chatNotifierProvider.notifier).resetChat();
          ref.read(ttsNotifierProvider.notifier).stop();
        });
      },
    );
  }

  void _playChatHistory(WidgetRef ref) {
    final chatHistory = ref.read(chatNotifierProvider).toList();
    ref.read(ttsNotifierProvider.notifier).speakChatHistory(chatHistory);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(chatNotifierProvider);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('AI English Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _resetChat(ref),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: SideMenu(
        onPlayAll: () {
          _playChatHistory(ref);
          // サイドメニューを閉じる
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false,
              padding: const EdgeInsets.all(8.0),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: data[index]);
              },
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (value) => _sendMessage(ref),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _sendMessage(ref),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: footer(context, false),
    );
  }
}
