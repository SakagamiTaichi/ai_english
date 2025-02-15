// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_history_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatHistoryDetail _$ChatHistoryDetailFromJson(Map<String, dynamic> json) {
  return _ChatHistoryDetail.fromJson(json);
}

/// @nodoc
mixin _$ChatHistoryDetail {
  String get set_id => throw _privateConstructorUsedError;
  int get message_order => throw _privateConstructorUsedError;
  int get speaker_number => throw _privateConstructorUsedError;
  String get message_en => throw _privateConstructorUsedError;
  String get message_ja => throw _privateConstructorUsedError;

  /// Serializes this ChatHistoryDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatHistoryDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatHistoryDetailCopyWith<ChatHistoryDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatHistoryDetailCopyWith<$Res> {
  factory $ChatHistoryDetailCopyWith(
          ChatHistoryDetail value, $Res Function(ChatHistoryDetail) then) =
      _$ChatHistoryDetailCopyWithImpl<$Res, ChatHistoryDetail>;
  @useResult
  $Res call(
      {String set_id,
      int message_order,
      int speaker_number,
      String message_en,
      String message_ja});
}

/// @nodoc
class _$ChatHistoryDetailCopyWithImpl<$Res, $Val extends ChatHistoryDetail>
    implements $ChatHistoryDetailCopyWith<$Res> {
  _$ChatHistoryDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatHistoryDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? set_id = null,
    Object? message_order = null,
    Object? speaker_number = null,
    Object? message_en = null,
    Object? message_ja = null,
  }) {
    return _then(_value.copyWith(
      set_id: null == set_id
          ? _value.set_id
          : set_id // ignore: cast_nullable_to_non_nullable
              as String,
      message_order: null == message_order
          ? _value.message_order
          : message_order // ignore: cast_nullable_to_non_nullable
              as int,
      speaker_number: null == speaker_number
          ? _value.speaker_number
          : speaker_number // ignore: cast_nullable_to_non_nullable
              as int,
      message_en: null == message_en
          ? _value.message_en
          : message_en // ignore: cast_nullable_to_non_nullable
              as String,
      message_ja: null == message_ja
          ? _value.message_ja
          : message_ja // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatHistoryDetailImplCopyWith<$Res>
    implements $ChatHistoryDetailCopyWith<$Res> {
  factory _$$ChatHistoryDetailImplCopyWith(_$ChatHistoryDetailImpl value,
          $Res Function(_$ChatHistoryDetailImpl) then) =
      __$$ChatHistoryDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String set_id,
      int message_order,
      int speaker_number,
      String message_en,
      String message_ja});
}

/// @nodoc
class __$$ChatHistoryDetailImplCopyWithImpl<$Res>
    extends _$ChatHistoryDetailCopyWithImpl<$Res, _$ChatHistoryDetailImpl>
    implements _$$ChatHistoryDetailImplCopyWith<$Res> {
  __$$ChatHistoryDetailImplCopyWithImpl(_$ChatHistoryDetailImpl _value,
      $Res Function(_$ChatHistoryDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatHistoryDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? set_id = null,
    Object? message_order = null,
    Object? speaker_number = null,
    Object? message_en = null,
    Object? message_ja = null,
  }) {
    return _then(_$ChatHistoryDetailImpl(
      set_id: null == set_id
          ? _value.set_id
          : set_id // ignore: cast_nullable_to_non_nullable
              as String,
      message_order: null == message_order
          ? _value.message_order
          : message_order // ignore: cast_nullable_to_non_nullable
              as int,
      speaker_number: null == speaker_number
          ? _value.speaker_number
          : speaker_number // ignore: cast_nullable_to_non_nullable
              as int,
      message_en: null == message_en
          ? _value.message_en
          : message_en // ignore: cast_nullable_to_non_nullable
              as String,
      message_ja: null == message_ja
          ? _value.message_ja
          : message_ja // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatHistoryDetailImpl implements _ChatHistoryDetail {
  const _$ChatHistoryDetailImpl(
      {required this.set_id,
      required this.message_order,
      required this.speaker_number,
      required this.message_en,
      required this.message_ja});

  factory _$ChatHistoryDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatHistoryDetailImplFromJson(json);

  @override
  final String set_id;
  @override
  final int message_order;
  @override
  final int speaker_number;
  @override
  final String message_en;
  @override
  final String message_ja;

  @override
  String toString() {
    return 'ChatHistoryDetail(set_id: $set_id, message_order: $message_order, speaker_number: $speaker_number, message_en: $message_en, message_ja: $message_ja)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatHistoryDetailImpl &&
            (identical(other.set_id, set_id) || other.set_id == set_id) &&
            (identical(other.message_order, message_order) ||
                other.message_order == message_order) &&
            (identical(other.speaker_number, speaker_number) ||
                other.speaker_number == speaker_number) &&
            (identical(other.message_en, message_en) ||
                other.message_en == message_en) &&
            (identical(other.message_ja, message_ja) ||
                other.message_ja == message_ja));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, set_id, message_order,
      speaker_number, message_en, message_ja);

  /// Create a copy of ChatHistoryDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatHistoryDetailImplCopyWith<_$ChatHistoryDetailImpl> get copyWith =>
      __$$ChatHistoryDetailImplCopyWithImpl<_$ChatHistoryDetailImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatHistoryDetailImplToJson(
      this,
    );
  }
}

abstract class _ChatHistoryDetail implements ChatHistoryDetail {
  const factory _ChatHistoryDetail(
      {required final String set_id,
      required final int message_order,
      required final int speaker_number,
      required final String message_en,
      required final String message_ja}) = _$ChatHistoryDetailImpl;

  factory _ChatHistoryDetail.fromJson(Map<String, dynamic> json) =
      _$ChatHistoryDetailImpl.fromJson;

  @override
  String get set_id;
  @override
  int get message_order;
  @override
  int get speaker_number;
  @override
  String get message_en;
  @override
  String get message_ja;

  /// Create a copy of ChatHistoryDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatHistoryDetailImplCopyWith<_$ChatHistoryDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
