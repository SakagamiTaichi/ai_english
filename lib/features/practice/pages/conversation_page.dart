import 'package:ai_english/core/components/header.dart';
import 'package:ai_english/core/constans/MessageConstant.dart';
import 'package:ai_english/core/utils/providers/tts_provider.dart';
import 'package:ai_english/features/practice/components/reversible_message_bubble.dart';
import 'package:ai_english/features/practice/components/side_menue.dart';
import 'package:ai_english/features/practice/models/conversation.dart';
import 'package:ai_english/features/practice/models/message.dart';
import 'package:ai_english/features/practice/providers/conversation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// IDを受け取る
class ConversationPage extends ConsumerWidget {
  final String id;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ConversationPage({super.key, required this.id});

  void _playConversation(WidgetRef ref, List<MessageResponse> chatHistories) {
    final messages = chatHistories
        .map((history) => Message(
            text: history.message_en, // 英語のメッセージを使用
            isUser:
                history.speaker_number == 0 // speaker_numberが0の場合はユーザーのメッセージ
            ))
        .toList();
    ref.read(ttsNotifierProvider.notifier).speakChatHistory(messages);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(conversationNotifierProvider(id));

    return Scaffold(
      key: _scaffoldKey,
      appBar: header(
        context,
        isDisplayBackButton: true,
        isDisplaySideMenuButton: true,
        scaffoldKey: _scaffoldKey,
      ),
      endDrawer: SideMenu(
        conversationId: id,
        showTestButton: true,
        onPlayAll: () {
          data.whenOrNull(
            data: (chatHistories) =>
                _playConversation(ref, chatHistories.messages),
          );
          // サイドメニューを閉じる
          Navigator.pop(context);
        },
        showPlayAllButton: true,
        showSpeedControl: true,
      ),
      body: data.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            Center(child: Text(MeesageConstant.failedToLoadData)),
        data: (chatHistories) => ListView.builder(
          itemCount: chatHistories.messages.length,
          itemBuilder: (context, index) {
            final chatHistory = chatHistories.messages[index];
            return ReversibleMessageBubble(
                onLongPress: () => ref.read(ttsNotifierProvider.notifier).speak(
                    Message(
                        text: chatHistory.message_en,
                        isUser: chatHistory.speaker_number == 0)),
                messageEnglish: chatHistory.message_en,
                messageJapanese: chatHistory.message_ja,
                speaker: chatHistory.speaker_number);
          },
        ),
      ),
    );
  }
}
