import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../generated/features/auth/models/auth_api_models.freezed.dart';
part '../../../generated/features/auth/models/auth_api_models.g.dart';

@freezed
class SignInRequestModel with _$SignInRequestModel {
  const factory SignInRequestModel({
    required String email,
    required String password,
  }) = _SignInRequestModel;

  factory SignInRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestModelFromJson(json);
}

@freezed
class SendVerificationCodeRequestModel with _$SendVerificationCodeRequestModel {
  const factory SendVerificationCodeRequestModel({
    required String email,
  }) = _SendVerificationCodeRequestModel;

  factory SendVerificationCodeRequestModel.fromJson(
          Map<String, dynamic> json) =>
      _$SendVerificationCodeRequestModelFromJson(json);
}

@freezed
class SignUpRequestModel with _$SignUpRequestModel {
  const factory SignUpRequestModel({
    required String email,
    required String password,
    required String code,
  }) = _SignUpRequestModel;

  factory SignUpRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestModelFromJson(json);
}

@freezed
class SendVerificationCodeResponseModel
    with _$SendVerificationCodeResponseModel {
  const factory SendVerificationCodeResponseModel({
    required String email,
  }) = _SendVerificationCodeResponseModel;

  factory SendVerificationCodeResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$SendVerificationCodeResponseModelFromJson(json);
}
