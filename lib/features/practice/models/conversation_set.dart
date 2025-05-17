import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/features/practice/models/conversation_set.freezed.dart';
part '../../../generated/features/practice/models/conversation_set.g.dart';

@freezed
class ConversationSetResponse with _$ConversationSetResponse {
  const factory ConversationSetResponse({
    required String id,
  }) = _ConversationSet;

  factory ConversationSetResponse.fromJson(Map<String, dynamic> json) =>
      _$ConversationSetResponseFromJson(json);
}
