import 'package:dio/dio.dart';

abstract class IApiClient {
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters});
  Future<Response> getStream(String path,
      {Map<String, dynamic>? queryParameters});
  Future<Response> put(String path, {dynamic data});
  Future<Response> post(String path, {dynamic data});
  Future<Response> delete(String path, {dynamic data});
}
