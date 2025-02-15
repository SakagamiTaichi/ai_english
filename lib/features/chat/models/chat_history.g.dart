// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatHistoryImpl _$$ChatHistoryImplFromJson(Map<String, dynamic> json) =>
    _$ChatHistoryImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$ChatHistoryImplToJson(_$ChatHistoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'created_at': instance.created_at.toIso8601String(),
    };
