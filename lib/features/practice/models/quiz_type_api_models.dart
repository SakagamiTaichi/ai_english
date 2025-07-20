import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/features/practice/models/quiz_type_api_models.freezed.dart';
part '../../../generated/features/practice/models/quiz_type_api_models.g.dart';

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
class QuizTypesResponse with _$QuizTypesResponse {
  const factory QuizTypesResponse({
    @JsonKey(name: 'quiz_types') required List<QuizType> quizTypes,
  }) = _QuizTypesResponse;

  factory QuizTypesResponse.fromJson(Map<String, dynamic> json) =>
      _$QuizTypesResponseFromJson(json);
}

@freezed
class Quiz with _$Quiz {
  const factory Quiz({
    required String id,
    required String content,
    required String type,
    required String difficulty,
  }) = _Quiz;

  factory Quiz.fromJson(Map<String, dynamic> json) =>
      _$QuizFromJson(json);
}