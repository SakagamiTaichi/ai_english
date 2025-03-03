import 'package:dio/dio.dart';

/// 認証トークンを自動的にリクエストに追加するインターセプター
class AuthInterceptor extends Interceptor {
  String? _accessToken;

  /// アクセストークンを設定
  void setToken(String? token) {
    _accessToken = token;
  }

  /// アクセストークンをクリア
  void clearToken() {
    _accessToken = null;
  }

  /// トークンが設定されているかどうか
  bool get hasToken => _accessToken != null && _accessToken!.isNotEmpty;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // トークンが存在する場合は、Authorizationヘッダーに追加
    if (hasToken) {
      options.headers['Authorization'] = 'Bearer $_accessToken';
    }

    // リクエストを続行
    return handler.next(options);
  }
}
