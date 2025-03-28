import 'package:ai_english/core/components/footer.dart';
import 'package:ai_english/core/components/header.dart';
import 'package:ai_english/core/constans/MessageConstant.dart';
import 'package:ai_english/features/practice/components/setting_panel.dart';
import 'package:ai_english/core/utils/providers/tts_provider.dart';
import 'package:ai_english/features/practice/components/reversible_message_bubble.dart';
import 'package:ai_english/features/practice/models/chat_history_detail.dart';
import 'package:ai_english/features/practice/models/message.dart';
import 'package:ai_english/features/practice/providers/conversation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// IDを受け取る
class ConversationPage extends ConsumerWidget {
  final String id;

  const ConversationPage({super.key, required this.id});

  void _playConversation(WidgetRef ref, List<Conversation> chatHistories) {
    final messages = chatHistories
        .map((history) => Message(
            text: history.message_en, // 英語のメッセージを使用
            isUser:
                history.speaker_number == 0 // speaker_numberが1の場合はユーザーのメッセージ
            ))
        .toList();
    ref.read(ttsNotifierProvider.notifier).speakChatHistory(messages);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(conversationNotifierProvider(id));
    // final notifier = ref.read(asyncChatHistoryDetailProvider(id).notifier);

    return Scaffold(
      appBar: header(context, isDisplayBackButton: true),
      body: Column(
        children: [
          SettingPanel(onPlayAll: () {
            data.whenOrNull(
              data: (chatHistories) => _playConversation(ref, chatHistories),
            );
          }),
          Expanded(
              child: data.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) =>
                Center(child: Text(MeesageConstant.failedToLoadData)),
            data: (chatHistories) => ListView.builder(
              itemCount: chatHistories.length,
              itemBuilder: (context, index) {
                final chatHistory = chatHistories[index];
                return ReversibleMessageBubble(
                    onLongPress: () => ref
                        .read(ttsNotifierProvider.notifier)
                        .speak(Message(
                            text: chatHistory.message_en,
                            isUser: chatHistory.speaker_number == 0)),
                    messageEnglish: chatHistory.message_en,
                    messageJapanese: chatHistory.message_ja,
                    speaker: chatHistory.speaker_number);
              },
            ),
          )),
        ],
      ),
      bottomNavigationBar: footer(context, false),
    );
  }
}
