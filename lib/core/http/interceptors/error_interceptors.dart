// lib/core/http/interceptors/error_interceptors.dart の修正
import 'package:ai_english/core/http/interceptors/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // エラーの詳細情報をログに出力（開発時のデバッグ用）

    if (kDebugMode) {
      debugPrint('DioError Type: ${err.type}');
      debugPrint('DioError Message: ${err.message}');
      debugPrint('DioError Response: ${err.response}');
    }

    // ネットワーク接続エラーの詳細判定
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.unknown) {
      throw NetworkException();
    }

    // 残りのエラー処理は既存のコードと同様
    switch (err.type) {
      case DioExceptionType.cancel:
        throw Exception('リクエストがキャンセルされました');
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw TimeoutException(err.response?.data['detail']);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.response?.data['detail']);
          case 401:
            throw UnauthorizedException(err.response?.data['detail']);
          case 403:
            throw ForbiddenException(err.response?.data['detail']);
          case 404:
            throw NotFoundException(err.response?.data['detail']);
          case 409:
            throw ConflictException(err.response?.data['detail']);
          case 500:
            throw ServerException(err.response?.data['detail']);
          case 503:
            throw ServiceUnavailableException(err.response?.data['detail']);
          default:
            throw ServerException(err.response?.data['detail']);
        }
      default:
        throw NetworkException();
    }
  }
}
