import 'package:ai_english/core/utils/providers/tts_provider.dart';
import 'package:ai_english/features/practice/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MessageBubble extends ConsumerWidget {
  final Message message;

  const MessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        // TTSプロバイダーを使用してメッセージを再生
        await ref.read(ttsNotifierProvider.notifier).speak(message);
      },
      child: Align(
        alignment:
            message.isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: message.isUser ? Colors.blueAccent : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: message.text.isEmpty
              ? const SpinKitThreeBounce(
                  color: Colors.grey,
                  size: 20.0,
                )
              : Text(
                  message.text,
                  style: TextStyle(
                    color: message.isUser ? Colors.white : Colors.black,
                  ),
                ),
        ),
      ),
    );
  }
}
