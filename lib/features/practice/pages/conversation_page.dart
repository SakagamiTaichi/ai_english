import 'package:ai_english/core/components/error_feedback.dart';
import 'package:ai_english/core/utils/providers/tts_provider.dart';
import 'package:ai_english/features/practice/components/reversible_message_bubble.dart';
import 'package:ai_english/features/practice/components/side_menue.dart';
import 'package:ai_english/features/practice/models/conversation.dart';
import 'package:ai_english/features/practice/models/message.dart';
import 'package:ai_english/features/practice/pages/conversations_page.dart';
import 'package:ai_english/features/practice/providers/conversation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lottie/lottie.dart';

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
    final notifier = ref.read(conversationNotifierProvider(id).notifier);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: Theme.of(context).appBarTheme.toolbarHeight,
        // 常に戻るボタンを表示
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => {
                  if (Navigator.canPop(context))
                    {Navigator.pop(context)}
                  else
                    {
                      // 戻れない場合はConversationsPageに遷移
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: const ConversationsPage(),
                          type: PageTransitionType.leftToRight,
                        ),
                      )
                    }
                }),
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
        loading: () => Center(
            child: Lottie.asset(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                'assets/lottie/loading.json',
                fit: BoxFit.contain,
                animate: true,
                repeat: true)),
        error: (error, _) => ErrorFeedback(
          error: error,
          onRetry: () => notifier.refresh(),
        ),
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
