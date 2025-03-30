import 'package:ai_english/core/components/footer.dart';
import 'package:ai_english/core/components/header.dart';
import 'package:ai_english/core/constans/MessageConstant.dart';
import 'package:ai_english/features/practice/components/test_card.dart';
import 'package:ai_english/features/practice/models/conversation.dart';
import 'package:ai_english/features/practice/models/recall_test_request_model.dart';
import 'package:ai_english/features/practice/pages/recall_test_summary_page.dart';
import 'package:ai_english/features/practice/providers/conversation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  final TextEditingController _answerController = TextEditingController();
  int _currentQuestionIndex = 0;
  bool _isAnswerRevealed = false;

  // ユーザーの解答を保持するリスト
  final List<String> _userAnswers = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  void _nextQuestion(List<MessageResponse> questions, bool wasSkipped) {
    // 現在の解答を保存
    setState(() {
      _userAnswers[_currentQuestionIndex] = _answerController.text;
    });

    // 最後の問題かどうかを確認
    if (_currentQuestionIndex == questions.length - 1) {
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
                      user_answer: _userAnswers[i],
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
    } else {
      // 次の問題に進む
      setState(() {
        _isAnswerRevealed = false;
        _currentQuestionIndex++;
        // 次の問題の解答がすでに入力されていれば、それを表示
        _answerController.text = _userAnswers[_currentQuestionIndex];
      });
    }
  }

  // 前の問題に戻る関数
  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      // 現在の解答を保存
      setState(() {
        _userAnswers[_currentQuestionIndex] = _answerController.text;
        _currentQuestionIndex--;
        _isAnswerRevealed = false;
        // 前の問題の解答を表示
        _answerController.text = _userAnswers[_currentQuestionIndex];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatHistoryDetailAsync =
        ref.watch(conversationNotifierProvider(widget.conversationId));

    return Scaffold(
      appBar: header(context),
      body: chatHistoryDetailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text(MeesageConstant.failedToLoadData)),
        data: (chatHistoryDetails) {
          if (chatHistoryDetails.conversations.isEmpty) {
            return const Center(child: Text('テスト問題がありません'));
          }
          // ここで配列のサイズを確保
          if (_userAnswers.length < chatHistoryDetails.conversations.length) {
            _userAnswers.addAll(List.filled(
                chatHistoryDetails.conversations.length - _userAnswers.length,
                ''));
          }

          final currentQuestion =
              chatHistoryDetails.conversations[_currentQuestionIndex];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress indicator
                  LinearProgressIndicator(
                    value: (_currentQuestionIndex + 1) /
                        chatHistoryDetails.conversations.length,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Question count
                  Text(
                    '問題 ${_currentQuestionIndex + 1}/${chatHistoryDetails.conversations.length}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  const SizedBox(height: 16),

                  // Japanese text to translate
                  TestCard(
                    context: context,
                    isQuize: true,
                    text: currentQuestion.message_ja,
                  ),

                  const SizedBox(height: 16),

                  if (!_isAnswerRevealed)
                    // Answer input field
                    TextField(
                      controller: _answerController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),

                  if (_isAnswerRevealed)
                    // Revealed answer
                    TestCard(
                      context: context,
                      isQuize: false,
                      text: currentQuestion.message_en,
                    ),

                  const SizedBox(height: 24),

                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 戻るボタン
                      ElevatedButton.icon(
                        onPressed: _currentQuestionIndex > 0
                            ? _previousQuestion
                            : null, // 最初の問題では無効化
                        icon: const Icon(Icons.arrow_back_ios_rounded),
                        label: const Text(''),
                        style: Theme.of(context).elevatedButtonTheme.style,
                      ),
                      // 次へボタン
                      ElevatedButton.icon(
                        onPressed: () => _nextQuestion(
                            chatHistoryDetails.conversations, false),
                        icon: const Icon(Icons.arrow_forward_ios_rounded),
                        label: const Text(''),
                        style: Theme.of(context).elevatedButtonTheme.style,
                      ),
                    ],
                  ),
                  // Add extra padding at bottom to ensure content isn't hidden by keyboard
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: footer(context, false),
    );
  }
}
