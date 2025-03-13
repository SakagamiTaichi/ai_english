import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/features/practice/models/recall_test_request_model.freezed.dart';
part '../../../generated/features/practice/models/recall_test_request_model.g.dart';

@freezed
class RecallTestAnswer with _$RecallTestAnswer {
  const factory RecallTestAnswer({
    required String user_answer,
    required String correct_answer,
  }) = _RecallTestAnswer;

  factory RecallTestAnswer.fromJson(Map<String, dynamic> json) =>
      _$RecallTestAnswerFromJson(json);
}

@freezed
class RecallTestRequestModel with _$RecallTestRequestModel {
  const factory RecallTestRequestModel({
    required List<RecallTestAnswer> answers,
  }) = _RecallTestRequestModel;

  factory RecallTestRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RecallTestRequestModelFromJson(json);
}
