import 'package:ai_english/core/components/error_feedback.dart';
import 'package:ai_english/core/components/footer.dart';
import 'package:ai_english/core/components/header.dart';
import 'package:ai_english/features/practice/components/test_card.dart';
import 'package:ai_english/features/practice/models/conversation.dart';
import 'package:ai_english/features/practice/models/recall_test_request_model.dart';
import 'package:ai_english/features/practice/pages/conversation_page.dart';
import 'package:ai_english/features/practice/pages/recall_test_summary_page.dart';
import 'package:ai_english/features/practice/providers/conversation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class EnglishRecallTestPage extends ConsumerStatefulWidget {
  final String conversationId;

  const EnglishRecallTestPage({
    super.key,
    required this.conversationId,
  });

  @override
  ConsumerState<EnglishRecallTestPage> createState() =>
      _EnglishRecallTestPageState();
}

class _EnglishRecallTestPageState extends ConsumerState<EnglishRecallTestPage> {
  // ユーザーの解答を保持するマップ（キー：問題のインデックス、値：ユーザーの回答）
  final Map<int, TextEditingController> _answerControllers = {};

  @override
  void dispose() {
    // すべてのコントローラーを破棄
    for (var controller in _answerControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  // 回答を終了して結果画面へ移動する関数
  void _finishTest(List<MessageResponse> questions) {
    // 確認ダイアログを表示
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('確認'),
          content: const Text('回答を終了しますか？'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ダイアログを閉じる
              },
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // ダイアログを閉じる

                // 回答を終了して結果画面へ移動
                List<RecallTestAnswer> answer = [];
                for (int i = 0; i < questions.length; i++) {
                  answer.add(RecallTestAnswer(
                    user_answer: _answerControllers[i]?.text ?? '',
                    message_order: questions[i].message_order,
                  ));
                }

                final requestModels = RecallTestRequestModel(
                    conversation_id: widget.conversationId, answers: answer);

                // Navigate to the summary screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RecallTestSummaryPage(requestModels: requestModels),
                  ),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(conversationNotifierProvider(widget.conversationId));

    final notifier =
        ref.read(conversationNotifierProvider(widget.conversationId).notifier);

    return Scaffold(
      appBar: header(context),
      body: data.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorFeedback(
          error: error,
          onRetry: () => notifier.refresh(),
        ),
        data: (chatHistoryDetails) {
          if (chatHistoryDetails.messages.isEmpty) {
            return const Center(child: Text('テスト問題がありません'));
          }

          // コントローラーが作成されていない問題のために新しいコントローラーを作成
          for (int i = 0; i < chatHistoryDetails.messages.length; i++) {
            if (!_answerControllers.containsKey(i)) {
              _answerControllers[i] = TextEditingController();
            }
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 総問題数の表示
                        Text(
                          '全${chatHistoryDetails.messages.length}問',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),

                        const SizedBox(height: 16),

                        // すべての問題と回答欄をリスト表示
                        ...List.generate(
                          chatHistoryDetails.messages.length,
                          (index) => _buildQuestionItem(
                            context,
                            chatHistoryDetails.messages[index],
                            index + 1,
                            chatHistoryDetails.messages.length,
                          ),
                        ),

                        // 回答終了ボタン
                        const SizedBox(height: 40),

                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    PageTransition(
                                      child: ConversationPage(
                                          id: widget.conversationId),
                                      type: PageTransitionType.fade,
                                    ),
                                    (route) => false)
                              },
                              icon: const Icon(Icons.cancel_outlined),
                              label: const Text('キャンセル'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32.0,
                                  vertical: 16.0,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton.icon(
                              onPressed: () =>
                                  _finishTest(chatHistoryDetails.messages),
                              icon: const Icon(Icons.check_circle_outline),
                              label: const Text('回答完了'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32.0,
                                  vertical: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: footer(context, false),
    );
  }

  // 個々の問題アイテムを構築するメソッド
  Widget _buildQuestionItem(
    BuildContext context,
    MessageResponse question,
    int currentNumber,
    int totalNumber,
  ) {
    final index = currentNumber - 1;

    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 問題番号
          Text(
            '問題 $currentNumber/$totalNumber',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 12),

          // 日本語テキスト
          TestCard(
            context: context,
            isQuize: true,
            text: question.message_ja,
          ),

          const SizedBox(height: 16),

          // 回答入力フィールド
          TextField(
            controller: _answerControllers[index],
            decoration: const InputDecoration(
              filled: true,
              border: OutlineInputBorder(),
              hintText: '英語で入力してください',
            ),
            maxLines: 3,
            style: GoogleFonts.rubik(
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
