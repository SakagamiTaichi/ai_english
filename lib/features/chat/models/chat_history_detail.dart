import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/features/chat/models/chat_history_detail.freezed.dart';
part '../../../generated/features/chat/models/chat_history_detail.g.dart';

@freezed
class ChatHistoryDetail with _$ChatHistoryDetail {
  const factory ChatHistoryDetail({
    required String set_id,
    required int message_order,
    required int speaker_number,
    required String message_en,
    required String message_ja,
  }) = _ChatHistoryDetail;

  factory ChatHistoryDetail.fromJson(Map<String, dynamic> json) =>
      _$ChatHistoryDetailFromJson(json);
}
