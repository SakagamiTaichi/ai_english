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

        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              // 「すべて」オプション
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: const Text('すべて'),
                  selected: filterState.quizTypeFilter == null,
                  onSelected: (selected) {
                    if (selected) {
                      filterNotifier.setQuizTypeFilter(null);
                    }
                  },
                  selectedColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  checkmarkColor: Theme.of(context).colorScheme.secondary,
                ),
              ),
              // 各クイズタイプのフィルター
              ...quizTypes.map((quizType) {
                final isSelected = filterState.quizTypeFilter == quizType.id;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(quizType.name),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        filterNotifier.setQuizTypeFilter(quizType.id);
                      } else {
                        filterNotifier.setQuizTypeFilter(null);
                      }
                    },
                    selectedColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    checkmarkColor: Theme.of(context).colorScheme.secondary,
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }
}
