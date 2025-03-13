import 'package:freezed_annotation/freezed_annotation.dart';

part 'recall_test_request_model.freezed.dart';
part 'recall_test_request_model.g.dart';

@freezed
class RecallTestAnser with _$RecallTestAnser {
  const factory RecallTestAnser({
    required String user_answer,
    required String correct_answer,
  }) = _RecallTestAnser;

  factory RecallTestAnser.fromJson(Map<String, dynamic> json) =>
      _$RecallTestAnserFromJson(json);
}

@freezed
class RecallTestRequestModel with _$RecallTestRequestModel {
  const factory RecallTestRequestModel({
    required List<RecallTestAnser> answers,
  }) = _RecallTestRequestModel;

  factory RecallTestRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RecallTestRequestModelFromJson(json);
}
