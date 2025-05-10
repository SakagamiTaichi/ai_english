// カスタム例外クラスの定義
class NetworkException implements Exception {
  NetworkException();
}

class BadRequestException implements Exception {
  final String? message;
  BadRequestException([this.message]);

  @override
  String toString() {
    return message ?? '';
  }
}

class ServerException implements Exception {
  final String? message;
  ServerException([this.message]);

  @override
  String toString() {
    return message ?? '';
  }
}

class UnauthorizedException implements Exception {
  final String? message;
  UnauthorizedException([this.message]);

  @override
  String toString() {
    return message ?? '';
  }
}

class NotFoundException implements Exception {
  final String? message;
  NotFoundException([this.message]);
  @override
  String toString() {
    return message ?? '';
  }
}

class TimeoutException implements Exception {
  final String? message;
  TimeoutException([this.message]);
  @override
  String toString() {
    return message ?? '';
  }
}

class ForbiddenException implements Exception {
  final String? message;
  ForbiddenException([this.message]);
  @override
  String toString() {
    return message ?? '';
  }
}

class ServiceUnavailableException implements Exception {
  final String? message;
  ServiceUnavailableException([this.message]);
  @override
  String toString() {
    return message ?? '';
  }
}

class ConflictException implements Exception {
  final String? message;
  ConflictException([this.message]);
  @override
  String toString() {
    return message ?? '';
  }
}
