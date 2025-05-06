import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/features/practice/models/conversations.freezed.dart';
part '../../../generated/features/practice/models/conversations.g.dart';

@freezed
class ConversationResponseConversation with _$ConversationResponseConversation {
  const factory ConversationResponseConversation(
      {required String id,
      required String title,
      required DateTime created_at,
      required int order}) = _ConversationResponseConversation;

  factory ConversationResponseConversation.fromJson(
          Map<String, dynamic> json) =>
      _$ConversationResponseConversationFromJson(json);
}

@freezed
class ConversationsResponse with _$ConversationsResponse {
  const factory ConversationsResponse({
    required List<ConversationResponseConversation> conversations,
  }) = _ConversationsResponse;

  factory ConversationsResponse.fromJson(Map<String, dynamic> json) =>
      _$ConversationsResponseFromJson(json);
}
