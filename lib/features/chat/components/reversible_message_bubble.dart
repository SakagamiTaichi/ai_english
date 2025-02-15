import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ReversibleMessageBubble extends HookWidget {
  final void Function() onLongPress;
  final String messageEnglish;
  final String messageJapanese;
  final int speaker;

  const ReversibleMessageBubble({
    super.key,
    required this.onLongPress,
    required this.messageEnglish,
    required this.messageJapanese,
    required this.speaker,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final showJapanese = useState(true);

    void toggleLanguage() {
      showJapanese.value = !showJapanese.value;
    }

    return GestureDetector(
      onTap: () async {
        // 言語切り替え
        toggleLanguage();
      },
      onLongPress: () async {
        // 長押しで音声再生（常に英語）
        onLongPress();
      },
      child: Align(
        alignment: speaker == 0 ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: speaker == 0 ? Colors.blueAccent : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: showJapanese.value
              ? Text(
                  messageJapanese,
                  style: TextStyle(
                    color: speaker == 0 ? Colors.white : Colors.black,
                  ),
                )
              : Text(
                  messageEnglish,
                  style: TextStyle(
                    color: speaker == 0 ? Colors.white : Colors.black,
                  ),
                ),
        ),
      ),
    );
  }
}
