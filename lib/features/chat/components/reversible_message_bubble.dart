import 'package:ai_english/core/utils/provider/tts_provider.dart';
import 'package:ai_english/features/chat/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ReversibleMessageBubble extends ConsumerStatefulWidget {
  final String messageEnglish;
  final String messageJapanese;
  final int speaker;

  const ReversibleMessageBubble({
    super.key,
    required this.messageEnglish,
    required this.messageJapanese,
    required this.speaker,
  });

  @override
  ConsumerState<ReversibleMessageBubble> createState() =>
      _ReversibleMessageBubbleState();
}

class _ReversibleMessageBubbleState
    extends ConsumerState<ReversibleMessageBubble> {
  bool _showJapanese = true; // 初期状態は日本語表示

  void _toggleLanguage() {
    setState(() {
      _showJapanese = !_showJapanese;
    });
  }

  @override
  Widget build(BuildContext context) {
    Message message = Message(
      text: _showJapanese ? widget.messageJapanese : widget.messageEnglish,
      isUser: widget.speaker == 0,
    );

    return GestureDetector(
      onTap: () async {
        // 言語切り替え
        _toggleLanguage();
      },
      onLongPress: () async {
        // 長押しで音声再生（常に英語）
        await ref.read(ttsNotifierProvider.notifier).speak(
            Message(text: widget.messageEnglish, isUser: widget.speaker == 0));
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
