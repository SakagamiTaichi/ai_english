import 'package:ai_english/features/practice/data/repository_providers.dart';
import 'package:ai_english/features/practice/models/study_record_api_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../generated/features/practice/providers/study_record_detail_provider.g.dart';

@riverpod
Future<StudyRecordDetailResponse> studyRecordDetail(
  Ref ref,
  String userAnswerId,
) async {
  final repository = ref.watch(studyRecordRepositoryProvider);
  return repository.getStudyRecordDetail(userAnswerId);
}
