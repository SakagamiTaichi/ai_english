import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/features/practice/models/study_record_api_models.freezed.dart';
part '../../../generated/features/practice/models/study_record_api_models.g.dart';

@freezed
class StudyRecordsResponse with _$StudyRecordsResponse {
  const factory StudyRecordsResponse({
    required List<StudyRecord> records,
    required List<QuizType> quiz_types,
  }) = _StudyRecordsResponse;

  factory StudyRecordsResponse.fromJson(Map<String, dynamic> json) =>
      _$StudyRecordsResponseFromJson(json);
}

@freezed
class StudyRecord with _$StudyRecord {
  const factory StudyRecord({
    @JsonKey(name: 'user_answer_id') required String userAnswerId,
    required int score,
    required String question,
    @JsonKey(name: 'quiz_type_id') required String quizTypeId,
    @JsonKey(name: 'answered_at') required String answeredAt,
    @JsonKey(name: 'answer_time_minutes') required int answerTimeMinutes,
    @JsonKey(name: 'answer_time_seconds') required int answerTimeSeconds,
    @JsonKey(name: 'is_completed_review') required bool isCompletedReview,
  }) = _StudyRecord;

  factory StudyRecord.fromJson(Map<String, dynamic> json) =>
      _$StudyRecordFromJson(json);
}

@freezed
class QuizType with _$QuizType {
  const factory QuizType({
    required String id,
    required String name,
    required String description,
  }) = _QuizType;

  factory QuizType.fromJson(Map<String, dynamic> json) =>
      _$QuizTypeFromJson(json);
}

@freezed
class StudyRecordDetailResponse with _$StudyRecordDetailResponse {
  const factory StudyRecordDetailResponse({
    @JsonKey(name: 'user_answers') required List<UserAnswer> userAnswers,
    required QuizDetail quiz,
  }) = _StudyRecordDetailResponse;

  factory StudyRecordDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$StudyRecordDetailResponseFromJson(json);
}

@freezed
class UserAnswer with _$UserAnswer {
  const factory UserAnswer({
    @JsonKey(name: 'user_answer') required String userAnswer,
    @JsonKey(name: 'ai_evaluation_score') required int aiEvaluationScore,
    @JsonKey(name: 'answered_at') required String answeredAt,
    @JsonKey(name: 'ai_feedback') required String aiFeedback,
    @JsonKey(name: 'ai_model_answer') required String aiModelAnswer,
  }) = _UserAnswer;

  factory UserAnswer.fromJson(Map<String, dynamic> json) =>
      _$UserAnswerFromJson(json);
}

@freezed
class QuizDetail with _$QuizDetail {
  const factory QuizDetail({
    required String id,
    required String content,
    required String type,
    required String difficulty,
  }) = _QuizDetail;

  factory QuizDetail.fromJson(Map<String, dynamic> json) => _$QuizDetailFromJson(json);
}
