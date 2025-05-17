import 'package:ai_english/core/components/error_feedback.dart';
import 'package:ai_english/core/components/footer.dart';
import 'package:ai_english/core/components/header.dart';
import 'package:ai_english/features/practice/models/recall_test_request_model.dart';
import 'package:ai_english/features/practice/pages/conversation_page.dart';
import 'package:ai_english/features/practice/providers/recall_test_result_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:page_transition/page_transition.dart';

class RecallTestSummaryPage extends ConsumerStatefulWidget {
  final RecallTestRequestModel requestModels;

  const RecallTestSummaryPage({super.key, required this.requestModels});

  @override
  ConsumerState<RecallTestSummaryPage> createState() =>
      _RecallTestSummaryPageState();
}

class _RecallTestSummaryPageState extends ConsumerState<RecallTestSummaryPage> {
  @override
  Widget build(BuildContext context) {
    final data =
        ref.watch(recallTestResultProviderProvider(widget.requestModels));

    final notifier = ref
        .read(recallTestResultProviderProvider(widget.requestModels).notifier);

    return Scaffold(
      appBar: header(context),
      body: data.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorFeedback(
          error: error,
          onRetry: () => notifier.refresh(),
        ),
        data: (results) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overall results section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'テスト結果',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '合計スコア',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                '${results.correct_rate}点',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            ],
                          ),
                          if (results.last_correct_rate != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '前回',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${results.last_correct_rate?.toStringAsFixed(1)}点',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                            color: Colors.grey,
                                          ),
                                    ),
                                    // Comparison with previous result
                                    if (results.last_correct_rate != null)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Row(
                                          children: [
                                            Icon(
                                              results.correct_rate >
                                                      results.last_correct_rate!
                                                  ? Icons.arrow_upward
                                                  : results.correct_rate <
                                                          results
                                                              .last_correct_rate!
                                                      ? Icons.arrow_downward
                                                      : Icons.drag_handle,
                                              color: results.correct_rate >
                                                      results.last_correct_rate!
                                                  ? Colors.green
                                                  : results.correct_rate <
                                                          results
                                                              .last_correct_rate!
                                                      ? Colors.red
                                                      : Colors.grey,
                                            ),
                                            const SizedBox(width: 4),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Results list
              Text(
                '詳細結果',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              // Individual question results
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: results.result.length,
                itemBuilder: (context, index) {
                  final result = results.result[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '問題 ${index + 1}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    result.is_correct
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: result.is_correct
                                        ? Colors.green
                                        : Colors.red,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    result.is_correct ? '正解' : '不正解',
                                    style: TextStyle(
                                      color: result.is_correct
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Similarity score with comparison to last score
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'スコア: ${result.similarity_to_correct.toStringAsFixed(0)}点',
                                style: TextStyle(
                                  color: result.similarity_to_correct > 70
                                      ? Colors.orange
                                      : Colors.red,
                                ),
                              ),
                              if (result.last_similarity_to_correct != null)
                                Row(
                                  children: [
                                    Text(
                                      '前回: ${result.last_similarity_to_correct!.toStringAsFixed(0)}%',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    if (result.similarity_to_correct !=
                                        result.last_similarity_to_correct)
                                      Icon(
                                        result.similarity_to_correct >
                                                result
                                                    .last_similarity_to_correct!
                                            ? Icons.arrow_upward
                                            : Icons.arrow_downward,
                                        color: result.similarity_to_correct >
                                                result
                                                    .last_similarity_to_correct!
                                            ? Colors.green
                                            : Colors.red,
                                        size: 16,
                                      ),
                                  ],
                                ),
                            ],
                          ),

                          // User answer with HTML rendering
                          const Divider(),
                          Text(
                            'あなたの回答:',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 4),
                          Html(
                            data: result.user_answer,
                            style: {
                              "del": Style(
                                backgroundColor: Colors.red.withAlpha(120),
                                textDecoration: TextDecoration.lineThrough,
                                color: Colors.red,
                              ),
                            },
                          ),

                          // Correct answer with HTML rendering
                          const Divider(),
                          Text(
                            '正解:',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 4),
                          Html(
                            data: result.correct_answer,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              // Bottom action buttons
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.replay),
                    label: const Text('もう一度挑戦'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            child: ConversationPage(
                                id: widget.requestModels.conversation_id),
                            type: PageTransitionType.fade,
                          ),
                          (route) => false);
                    },
                    icon: const Icon(Icons.home),
                    label: const Text('学習に戻る'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: footer(context, false),
    );
  }
}
