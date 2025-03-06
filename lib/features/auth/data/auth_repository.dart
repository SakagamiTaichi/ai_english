import 'package:ai_english/core/http/iapi_client.dart';
import 'package:ai_english/features/auth/models/auth_models.dart';

abstract class IAuthRepository {
  Future<void> signUp(String email, String password);
  Future<Token> signIn(String email, String password);
  Future<Token> refreshToken(String refreshToken);
  Future<User> getCurrentUser(String accessToken);
}

class AuthRepository implements IAuthRepository {
  final IApiClient _apiClient;

  AuthRepository(this._apiClient);

  @override
  Future<void> signUp(String email, String password) async {
    try {
      await _apiClient.post('/auth/signup', data: {
        'email': email,
        'password': password,
      });

      // No longer automatically signing in after registration
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Token> signIn(String email, String password) async {
    try {
      // サインイン前に既存のトークンをクリア
      _apiClient.clearAuthToken();

      final response = await _apiClient.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

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
}
