import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_history.freezed.dart';
part 'chat_history.g.dart';

@freezed
class ChatHistory with _$ChatHistory {
  const factory ChatHistory({
    required String id,
    required String title,
    required DateTime created_at,
  }) = _ChatHistory;

  factory ChatHistory.fromJson(Map<String, dynamic> json) =>
      _$ChatHistoryFromJson(json);
}
