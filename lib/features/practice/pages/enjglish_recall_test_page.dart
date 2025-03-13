import 'package:ai_english/core/components/footer.dart';
import 'package:ai_english/core/components/header.dart';
import 'package:ai_english/features/practice/models/chat_history_detail.dart';
import 'package:ai_english/features/practice/models/recall_test_request_model.dart';
import 'package:ai_english/features/practice/pages/recall_test_summary_page.dart';
import 'package:ai_english/features/practice/providers/chat_history_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnglishRecallTestPage extends ConsumerStatefulWidget {
  final String chatHistoryId;

  const EnglishRecallTestPage({
    super.key,
    required this.chatHistoryId,
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

  void _nextQuestion(List<Conversation> questions, bool wasSkipped) {
    // 現在の解答を保存
    setState(() {
      _userAnswers[_currentQuestionIndex] = _answerController.text;
    });

    // Move to the next question or summary screen
    setState(() {
      _isAnswerRevealed = false;
      if (_currentQuestionIndex < questions.length - 1) {
        _currentQuestionIndex++;
        // 次の問題の解答がすでに入力されていれば、それを表示
        _answerController.text = _userAnswers[_currentQuestionIndex];
      } else {
        List<RecallTestAnswer> answer = [];
        for (int i = 0; i < questions.length; i++) {
          answer.add(RecallTestAnswer(
            user_answer: _userAnswers[i],
            correct_answer: questions[i].message_en,
          ));
        }

        final requestModels = RecallTestRequestModel(answers: answer);

        // Navigate to the summary screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RecallTestSummaryPage(requestModels: requestModels),
          ),
        );
      }
    });
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
        ref.watch(conversationNotifierProvider(widget.chatHistoryId));

    return Scaffold(
      appBar: header(context, '英語リコールテスト'),
      body: chatHistoryDetailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('エラーが発生しました: $error')),
        data: (chatHistoryDetails) {
          if (chatHistoryDetails.isEmpty) {
            return const Center(child: Text('テスト問題がありません'));
          }

          // ここで配列のサイズを確保
          if (_userAnswers.length < chatHistoryDetails.length) {
            _userAnswers.addAll(List.filled(
                chatHistoryDetails.length - _userAnswers.length, ''));
          }

          final currentQuestion = chatHistoryDetails[_currentQuestionIndex];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress indicator
                  LinearProgressIndicator(
                    value:
                        (_currentQuestionIndex + 1) / chatHistoryDetails.length,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Question count
                  Text(
                    '問題 ${_currentQuestionIndex + 1}/${chatHistoryDetails.length}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  const SizedBox(height: 24),

                  // Japanese text to translate
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '日本語:',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            currentQuestion.message_ja,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  if (!_isAnswerRevealed)
                    // Answer input field
                    TextField(
                      controller: _answerController,
                      decoration: const InputDecoration(
                        labelText: '英語で答えてください',
                        border: OutlineInputBorder(),
                        hintText: 'Type your answer in English...',
                      ),
                      maxLines: 3,
                    ),

                  if (_isAnswerRevealed)
                    // Revealed answer
                    Card(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '正解:',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              currentQuestion.message_en,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 24),

                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // 戻るボタン
                      ElevatedButton.icon(
                        onPressed: _currentQuestionIndex > 0
                            ? _previousQuestion
                            : null, // 最初の問題では無効化
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('前へ'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                        ).copyWith(
                          backgroundColor: _currentQuestionIndex > 0
                              ? WidgetStateProperty.all(Colors.blue)
                              : WidgetStateProperty.all(Colors.grey[300]),
                          foregroundColor: _currentQuestionIndex > 0
                              ? WidgetStateProperty.all(Colors.white)
                              : WidgetStateProperty.all(Colors.grey[600]),
                        ),
                      ),
                      // Check Answer / Next button
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _isAnswerRevealed = !_isAnswerRevealed;
                          });
                        },
                        icon: Icon(_isAnswerRevealed
                            ? Icons.arrow_forward
                            : Icons.check),
                        label: Text(_isAnswerRevealed ? '回答へ戻る' : '正解を確認'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                        ),
                      ),
                      // 次へボタン
                      ElevatedButton.icon(
                        onPressed: () =>
                            _nextQuestion(chatHistoryDetails, false),
                        icon: const Icon(Icons.skip_next),
                        label: const Text('次へ'),
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
