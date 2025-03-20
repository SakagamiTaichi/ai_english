import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/features/practice/models/recall_test_response_model.freezed.dart';
part '../../../generated/features/practice/models/recall_test_response_model.g.dart';

@freezed
class RecallTestResponseModel with _$RecallTestResponseModel {
  const factory RecallTestResponseModel({
    required String user_answer,
    required String correct_answer,
    required bool is_correct,
    required int similarity_to_correct,
    required int? last_similarity_to_correct,
  }) = _RecallTestResponseModel;

  factory RecallTestResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RecallTestResponseModelFromJson(json);
}

@freezed
class RecallTestSummaryResponseModel with _$RecallTestSummaryResponseModel {
  const factory RecallTestSummaryResponseModel({
    required int correct_rate,
    required int? last_correct_rate,
    required List<RecallTestResponseModel> result,
  }) = _RecallTestSummaryResponseModel;

  factory RecallTestSummaryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RecallTestSummaryResponseModelFromJson(json);
}
