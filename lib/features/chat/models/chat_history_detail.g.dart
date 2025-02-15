// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_history_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatHistoryDetailImpl _$$ChatHistoryDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatHistoryDetailImpl(
      set_id: json['set_id'] as String,
      message_order: (json['message_order'] as num).toInt(),
      speaker_number: (json['speaker_number'] as num).toInt(),
      message_en: json['message_en'] as String,
      message_ja: json['message_ja'] as String,
    );

Map<String, dynamic> _$$ChatHistoryDetailImplToJson(
        _$ChatHistoryDetailImpl instance) =>
    <String, dynamic>{
      'set_id': instance.set_id,
      'message_order': instance.message_order,
      'speaker_number': instance.speaker_number,
      'message_en': instance.message_en,
      'message_ja': instance.message_ja,
    };
