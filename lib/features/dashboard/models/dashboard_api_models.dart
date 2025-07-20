import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/features/dashboard/models/dashboard_api_models.freezed.dart';
part '../../../generated/features/dashboard/models/dashboard_api_models.g.dart';

@freezed
class HomeResponseModel with _$HomeResponseModel {
  const factory HomeResponseModel({
    required String message,
    @JsonKey(name: 'continuous_learning_days') required int continuousLearningDays,
    @JsonKey(name: 'pending_review_count') required int pendingReviewCount,
    @JsonKey(name: 'all_quiz_count') required int allQuizCount,
    @JsonKey(name: 'complete_review_count') required int completeReviewCount,
    @JsonKey(name: 'average_score') required double averageScore,
  }) = _HomeResponseModel;

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseModelFromJson(json);
}