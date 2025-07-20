import 'package:ai_english/features/practice/data/repository_providers.dart';
import 'package:ai_english/features/practice/models/study_record_api_models.dart';
import 'package:ai_english/features/practice/models/study_record_filter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../generated/features/practice/providers/study_record_provider.g.dart';

@riverpod
class StudyRecordFilterNotifier extends _$StudyRecordFilterNotifier {
  @override
  StudyRecordFilterState build() {
    return StudyRecordFilterState(
      timeFilter: StudyRecordFilter.all,
      quizTypeFilter: null,
    );
  }

  void setTimeFilter(StudyRecordFilter filter) {
    state = state.copyWith(timeFilter: filter);
  }

  void setQuizTypeFilter(String? quizTypeId) {
    state = state.copyWith(quizTypeFilter: quizTypeId);
  }

  void clearFilters() {
    state = StudyRecordFilterState(
      timeFilter: StudyRecordFilter.all,
      quizTypeFilter: null,
    );
  }
}

class StudyRecordFilterState {
  final StudyRecordFilter timeFilter;
  final String? quizTypeFilter;

  const StudyRecordFilterState({
    required this.timeFilter,
    this.quizTypeFilter,
  });

  StudyRecordFilterState copyWith({
    StudyRecordFilter? timeFilter,
    String? quizTypeFilter,
  }) {
    return StudyRecordFilterState(
      timeFilter: timeFilter ?? this.timeFilter,
      quizTypeFilter: quizTypeFilter,
    );
  }
}

@riverpod
Future<StudyRecordsResponse> studyRecords(Ref ref) async {
  final repository = ref.watch(studyRecordRepositoryProvider);
  return await repository.getStudyRecords();
}

@riverpod
List<StudyRecord> filteredStudyRecords(Ref ref) {
  final studyRecordsAsync = ref.watch(studyRecordsProvider);
  final filterState = ref.watch(studyRecordFilterNotifierProvider);

  return studyRecordsAsync.when(
    data: (response) {
      var records = response.records;

      // クイズタイプでフィルタリング
      if (filterState.quizTypeFilter != null) {
        records = records
            .where((record) => record.quizTypeId == filterState.quizTypeFilter)
            .toList();
      }

      // 時間でフィルタリング
      final now = DateTime.now();
      switch (filterState.timeFilter) {
        case StudyRecordFilter.thisWeek:
          final weekStart = now.subtract(Duration(days: now.weekday - 1));
          records = records.where((record) {
            final recordDate = DateTime.parse(record.answeredAt);
            return recordDate.isAfter(weekStart);
          }).toList();
          break;
        case StudyRecordFilter.thisMonth:
          final monthStart = DateTime(now.year, now.month, 1);
          records = records.where((record) {
            final recordDate = DateTime.parse(record.answeredAt);
            return recordDate.isAfter(monthStart);
          }).toList();
          break;
        case StudyRecordFilter.all:
          break;
      }

      return records;
    },
    loading: () => [],
    error: (error, stack) => [],
  );
}

@riverpod
StudyRecordSummary studyRecordSummary(Ref ref) {
  final filteredRecords = ref.watch(filteredStudyRecordsProvider);

  if (filteredRecords.isEmpty) {
    return const StudyRecordSummary(
      totalCount: 0,
      averageScore: 0.0,
      averageTimeMinutes: 0.0,
    );
  }

  final totalCount = filteredRecords.length;
  final totalScore =
      filteredRecords.fold<int>(0, (sum, record) => sum + record.score);
  final averageScore = totalScore / totalCount;

  final totalTimeMinutes = filteredRecords.fold<double>(
    0.0,
    (sum, record) =>
        sum + record.answerTimeMinutes + (record.answerTimeSeconds / 60.0),
  );
  final averageTimeMinutes = totalTimeMinutes / totalCount;

  return StudyRecordSummary(
    totalCount: totalCount,
    averageScore: averageScore,
    averageTimeMinutes: averageTimeMinutes,
  );
}

class StudyRecordSummary {
  final int totalCount;
  final double averageScore;
  final double averageTimeMinutes;

  const StudyRecordSummary({
    required this.totalCount,
    required this.averageScore,
    required this.averageTimeMinutes,
  });
}
