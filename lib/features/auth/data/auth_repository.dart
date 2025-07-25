import 'package:ai_english/core/http/iapi_client.dart';
import 'package:ai_english/features/auth/models/auth_api_models.dart';
import 'package:ai_english/features/auth/models/auth_models.dart';

abstract class IAuthRepository {
  Future<Token> signUp(SignUpRequestModel request);
  Future<Token> signIn(SignInRequestModel request);
  Future<Token> refreshToken(String refreshToken);
  Future<User> getCurrentUser(String accessToken);
  Future<SendVerificationCodeResponseModel> sendVerificationCode(
      SendVerificationCodeRequestModel email);
}

class AuthRepository implements IAuthRepository {
  final IApiClient _apiClient;

  AuthRepository(this._apiClient);

  @override
  Future<Token> signUp(SignUpRequestModel request) async {
    try {
      // サインアップ前に既存のトークンをクリア
      _apiClient.clearAuthToken();
      final response =
          await _apiClient.post('/auth/signup', data: request.toJson());

      final token = Token.fromJson(response.data);
      // アクセストークンを設定
      _apiClient.setAuthToken(token.access_token);

      return token;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Token> signIn(SignInRequestModel request) async {
    try {
      // サインイン前に既存のトークンをクリア
      _apiClient.clearAuthToken();

      final response =
          await _apiClient.post('/auth/login', data: request.toJson());

      final token = Token.fromJson(response.data);
      // アクセストークンを設定
      _apiClient.setAuthToken(token.access_token);

      return token;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Token> refreshToken(String refreshToken) async {
    try {
      final response = await _apiClient.post('/auth/refresh', data: {
        'refresh_token': refreshToken,
      });

      final token = Token.fromJson(response.data);
      // 新しいアクセストークンを設定
      _apiClient.setAuthToken(token.access_token);

      return token;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> getCurrentUser(String accessToken) async {
    try {
      // トークンを設定
      _apiClient.setAuthToken(accessToken);

      final response = await _apiClient.get('/auth/me');
      return User.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SendVerificationCodeResponseModel> sendVerificationCode(
      SendVerificationCodeRequestModel request) async {
    try {
      var response = await _apiClient.post('/auth/send-verification-code',
          data: request.toJson());

      return SendVerificationCodeResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
