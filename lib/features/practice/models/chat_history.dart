import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/features/practice/models/chat_history.freezed.dart';
part '../../../generated/features/practice/models/chat_history.g.dart';

@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    required String id,
    required String title,
    required DateTime created_at,
  }) = _ChatHistory;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}
