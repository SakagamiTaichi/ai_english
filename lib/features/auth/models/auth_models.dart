import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/features/auth/models/auth_models.freezed.dart';
part '../../../generated/features/auth/models/auth_models.g.dart';

@freezed
class Token with _$Token {
  const factory Token({
    required String access_token,
    required String refresh_token,
    required String token_type,
  }) = _Token;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required bool is_active,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    Token? token,
    User? user,
    @Default(false) bool isLoading,
    @Default(false) bool isAuthenticated,
  }) = _AuthState;
}
