import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/features/practice/models/conversation.freezed.dart';
part '../../../generated/features/practice/models/conversation.g.dart';

@freezed
class MessageResponse with _$MessageResponse {
  const factory MessageResponse({
    required String conversation_id,
    required int message_order,
    required int speaker_number,
    required String message_en,
    required String message_ja,
  }) = _Message;

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseFromJson(json);
}

@freezed
class ConversationResponse with _$ConversationResponse {
  const factory ConversationResponse({
    required List<MessageResponse> conversations,
  }) = _ConversationResponse;

  factory ConversationResponse.fromJson(Map<String, dynamic> json) =>
      _$ConversationResponseFromJson(json);
}
