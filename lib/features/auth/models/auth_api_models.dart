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
