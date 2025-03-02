import 'package:ai_english/core/components/footer.dart';
import 'package:ai_english/features/chat/components/message_bubble.dart';
import 'package:ai_english/features/chat/components/reset_alert_dialog.dart';
import 'package:ai_english/features/chat/components/setting_panel.dart';
import 'package:ai_english/features/chat/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_english/core/utils/provider/tts_provider.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: true,
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
          SettingPanel(
            onPlayAll: () {
              _playChatHistory(ref);
            },
            onSpeedChanged: (speed) {
              // 再生速度の変更処理をここに追加
              ref.read(ttsNotifierProvider.notifier).setSpeechRate(speed);
            },
          ),
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
      bottomNavigationBar: footer(context),
    );
  }
}
