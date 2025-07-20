import 'package:ai_english/features/practice/models/study_record_api_models.dart';
import 'package:ai_english/features/practice/models/study_record_filter.dart';
import 'package:ai_english/features/practice/providers/study_record_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudyFilterButtons extends ConsumerWidget {
  final List<QuizType> quizTypes;

  const StudyFilterButtons({
    super.key,
    required this.quizTypes,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(studyRecordFilterNotifierProvider);
    final filterNotifier = ref.read(studyRecordFilterNotifierProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'フィルター',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        
        // 時間フィルター
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: StudyRecordFilter.values.map((filter) {
            final isSelected = filterState.timeFilter == filter;
            return FilterChip(
              label: Text(filter.displayName),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  filterNotifier.setTimeFilter(filter);
                  // 時間フィルターを変更した時はクイズタイプフィルターをクリア
                  filterNotifier.setQuizTypeFilter(null);
                }
              },
              selectedColor: Theme.of(context).colorScheme.primaryContainer,
              checkmarkColor: Theme.of(context).colorScheme.primary,
            );
          }).toList(),
        ),
        
        const SizedBox(height: 16),
        
        // クイズタイプフィルター
        Text(
          'クイズの種類',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: quizTypes.map((quizType) {
            final isSelected = filterState.quizTypeFilter == quizType.id;
            return FilterChip(
              label: Text(quizType.name),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  filterNotifier.setQuizTypeFilter(quizType.id);
                  // クイズタイプフィルターを選択した時は時間フィルターを「すべて」に戻す
                  filterNotifier.setTimeFilter(StudyRecordFilter.all);
                } else {
                  filterNotifier.setQuizTypeFilter(null);
                }
              },
              selectedColor: Theme.of(context).colorScheme.secondaryContainer,
              checkmarkColor: Theme.of(context).colorScheme.secondary,
            );
          }).toList(),
        ),
        
        // フィルタークリアボタン
        if (filterState.timeFilter != StudyRecordFilter.all || 
            filterState.quizTypeFilter != null) ...[
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: () => filterNotifier.clearFilters(),
            icon: const Icon(Icons.clear),
            label: const Text('フィルターをクリア'),
          ),
        ],
      ],
    );
  }
}