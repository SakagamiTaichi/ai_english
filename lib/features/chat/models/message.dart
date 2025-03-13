import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/features/chat/models/message.freezed.dart';
part '../../../generated/features/chat/models/message.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String text,
    required bool isUser,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
