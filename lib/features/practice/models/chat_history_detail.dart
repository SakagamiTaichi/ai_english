import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/features/practice/models/chat_history_detail.freezed.dart';
part '../../../generated/features/practice/models/chat_history_detail.g.dart';

@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    required String conversation_id,
    required int message_order,
    required int speaker_number,
    required String message_en,
    required String message_ja,
  }) = _ChatHistoryDetail;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}
