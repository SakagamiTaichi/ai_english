// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatHistory _$ChatHistoryFromJson(Map<String, dynamic> json) {
  return _ChatHistory.fromJson(json);
}

/// @nodoc
mixin _$ChatHistory {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get created_at => throw _privateConstructorUsedError;

  /// Serializes this ChatHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatHistoryCopyWith<ChatHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatHistoryCopyWith<$Res> {
  factory $ChatHistoryCopyWith(
          ChatHistory value, $Res Function(ChatHistory) then) =
      _$ChatHistoryCopyWithImpl<$Res, ChatHistory>;
  @useResult
  $Res call({String id, String title, DateTime created_at});
}

/// @nodoc
class _$ChatHistoryCopyWithImpl<$Res, $Val extends ChatHistory>
    implements $ChatHistoryCopyWith<$Res> {
  _$ChatHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? created_at = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatHistoryImplCopyWith<$Res>
    implements $ChatHistoryCopyWith<$Res> {
  factory _$$ChatHistoryImplCopyWith(
          _$ChatHistoryImpl value, $Res Function(_$ChatHistoryImpl) then) =
      __$$ChatHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, DateTime created_at});
}

/// @nodoc
class __$$ChatHistoryImplCopyWithImpl<$Res>
    extends _$ChatHistoryCopyWithImpl<$Res, _$ChatHistoryImpl>
    implements _$$ChatHistoryImplCopyWith<$Res> {
  __$$ChatHistoryImplCopyWithImpl(
      _$ChatHistoryImpl _value, $Res Function(_$ChatHistoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? created_at = null,
  }) {
    return _then(_$ChatHistoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      created_at: null == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatHistoryImpl implements _ChatHistory {
  const _$ChatHistoryImpl(
      {required this.id, required this.title, required this.created_at});

  factory _$ChatHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatHistoryImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final DateTime created_at;

  @override
  String toString() {
    return 'ChatHistory(id: $id, title: $title, created_at: $created_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, created_at);

  /// Create a copy of ChatHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatHistoryImplCopyWith<_$ChatHistoryImpl> get copyWith =>
      __$$ChatHistoryImplCopyWithImpl<_$ChatHistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatHistoryImplToJson(
      this,
    );
  }
}

abstract class _ChatHistory implements ChatHistory {
  const factory _ChatHistory(
      {required final String id,
      required final String title,
      required final DateTime created_at}) = _$ChatHistoryImpl;

  factory _ChatHistory.fromJson(Map<String, dynamic> json) =
      _$ChatHistoryImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  DateTime get created_at;

  /// Create a copy of ChatHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatHistoryImplCopyWith<_$ChatHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
