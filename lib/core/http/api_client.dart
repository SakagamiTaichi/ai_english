import 'package:ai_english/core/constans/constans.dart';
import 'package:ai_english/core/http/iapi_client.dart';
import 'package:ai_english/core/http/interceptors/error_interceptors.dart';
import 'package:dio/dio.dart';

class ApiClient implements IApiClient {
  late Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        // タイムアウト設定
        connectTimeout: Duration(milliseconds: ApiConstants.connectionTimeout),
        // レスポンスのタイムアウト設定
        receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
      ),
    );

    // インターセプターの追加
    _dio.interceptors.addAll([
      ErrorInterceptor(),
      // LogInterceptor(responseBody: true),
    ]);
  }

  @override
  // GET リクエスト
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path,
          queryParameters: queryParameters,
          options: Options(responseType: ResponseType.json));
    } catch (e) {
      rethrow;
    }
  }

  @override
  // ストリーミング形式Getリクエスト
  Future<Response> getStream(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          responseType: ResponseType.stream,
          headers: {
            'Accept': 'text/event-stream',
            'Connection': 'keep-alive',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override // Putリクエスト
  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  // POST リクエスト
  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  // DELETE リクエスト
  Future<Response> delete(String path, {dynamic data}) async {
    try {
      return await _dio.delete(path, data: data);
    } catch (e) {
      rethrow;
    }
  }
}
