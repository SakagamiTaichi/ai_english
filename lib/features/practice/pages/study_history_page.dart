import 'package:ai_english/core/components/footer.dart';
import 'package:ai_english/features/practice/components/study_record_card.dart';
import 'package:ai_english/features/practice/components/study_summary_card.dart';
import 'package:ai_english/features/practice/components/study_filter_buttons.dart';
import 'package:ai_english/features/practice/models/study_record_api_models.dart';
import 'package:ai_english/features/practice/providers/study_record_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudyHistoryPage extends ConsumerWidget {
  const StudyHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studyRecordsAsync = ref.watch(studyRecordsProvider);
    final filteredRecords = ref.watch(filteredStudyRecordsProvider);
    final summary = ref.watch(studyRecordSummaryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('学習履歴'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // サマリーカード
              StudySummaryCard(summary: summary),
              const SizedBox(height: 16),

              // フィルターボタン
              studyRecordsAsync.when(
                data: (response) => StudyFilterButtons(
                  quizTypes: response.quiz_types,
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => const SizedBox.shrink(),
              ),
              const SizedBox(height: 16),

              // 学習履歴タイトル
              Text(
                '学習履歴',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              // 学習履歴一覧
              studyRecordsAsync.when(
                data: (response) {
                  if (filteredRecords.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 32),
                          Icon(
                            Icons.history_edu,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '学習履歴がありません',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: filteredRecords.map((record) {
                      final quizType = response.quiz_types.firstWhere(
                        (type) => type.id == record.quizTypeId,
                        orElse: () => QuizType(
                          id: '',
                          name: '不明',
                          description: '',
                        ),
                      );
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: StudyRecordCard(
                          record: record,
                          quizType: quizType,
                        ),
                      );
                    }).toList(),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'エラーが発生しました',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        error.toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: footer(context, false),
    );
  }
}
