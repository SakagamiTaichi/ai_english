import 'package:ai_english/features/chat/pages/widgets/message_bubble.dart';
import 'package:ai_english/features/chat/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends ConsumerWidget {
  ChatPage({super.key});

  final TextEditingController _controller = TextEditingController();

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
        return AlertDialog(
          title: const Text('Confirm Reset'),
          content: const Text('Are you sure you want to reset the chat?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Reset'),
              onPressed: () {
                ref.read(chatNotifierProvider.notifier).resetChat();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(chatNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('AI English Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _resetChat(ref),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false,
              padding: const EdgeInsets.all(8.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(message: messages[index]);
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
                    maxLines: 2,
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'メッセージを入力...',
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
    );
  }
}
