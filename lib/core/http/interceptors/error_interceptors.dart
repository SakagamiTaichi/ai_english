import 'package:ai_english/core/http/interceptors/exceptions.dart';
import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw TimeoutException('通信がタイムアウトしました');
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 401:
            throw UnauthorizedException('認証エラーが発生しました');
          case 404:
            throw NotFoundException('リソースが見つかりません');
          default:
            throw ServerException('サーバーエラーが発生しました');
        }
      default:
        throw NetworkException('ネットワークエラーが発生しました');
    }
  }
}
