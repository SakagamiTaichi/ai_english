import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/features/practice/models/conversations.freezed.dart';
part '../../../generated/features/practice/models/conversations.g.dart';

@freezed
class ConversationResponse with _$ConversationResponse {
  const factory ConversationResponse({
    required String id,
    required String title,
    required DateTime created_at,
  }) = _ConversationResponse;

  factory ConversationResponse.fromJson(Map<String, dynamic> json) =>
      _$ConversationResponseFromJson(json);
}

@freezed
class ConversationsResponse with _$ConversationsResponse {
  const factory ConversationsResponse({
    required List<ConversationResponse> conversations,
  }) = _ConversationsResponse;

  factory ConversationsResponse.fromJson(Map<String, dynamic> json) =>
      _$ConversationsResponseFromJson(json);
}
