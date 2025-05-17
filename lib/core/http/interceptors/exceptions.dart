// カスタム例外クラスの定義
class NetworkException implements Exception {
  NetworkException();
}

class BadRequestException implements Exception {
  final String? message;
  BadRequestException([this.message]);
}

class ServerException implements Exception {
  final String? message;
  ServerException([this.message]);
}

class UnauthorizedException implements Exception {
  final String? message;
  UnauthorizedException([this.message]);
}

class NotFoundException implements Exception {
  final String? message;
  NotFoundException([this.message]);
}

class TimeoutException implements Exception {
  final String? message;
  TimeoutException([this.message]);
}

class ForbiddenException implements Exception {
  final String? message;
  ForbiddenException([this.message]);
}

class ServiceUnavailableException implements Exception {
  final String? message;
  ServiceUnavailableException([this.message]);
}

class ConflictException implements Exception {
  final String? message;
  ConflictException([this.message]);
}
