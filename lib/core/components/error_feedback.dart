import 'package:ai_english/core/http/interceptors/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ErrorFeedback extends StatelessWidget {
  final dynamic error;
  final VoidCallback? onRetry;

  const ErrorFeedback({
    super.key,
    required this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    // エラー情報を一度に取得
    final errorDetails = _getErrorDetails();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              errorDetails.icon,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              errorDetails.title,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              errorDetails.message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('再試行'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // エラー情報をまとめて取得するメソッド
  ErrorDetails _getErrorDetails() {
    // DioExceptionの場合
    if (error is DioException) {
      final e = error as DioException;
      return _getErrorDetailsFromDioError(e.error);
    }

    // 直接例外オブジェクトの場合
    return _getErrorDetailsFromDirectError(error);
  }

  // Dioエラーの内部エラーからErrorDetailsを取得
  ErrorDetails _getErrorDetailsFromDioError(dynamic errorObj) {
    if (errorObj is NetworkException) {
      return ErrorDetails.network(errorObj.toString());
    } else if (errorObj is TimeoutException) {
      return ErrorDetails.timeout(errorObj.toString());
    } else if (errorObj is UnauthorizedException) {
      return ErrorDetails.unauthorized(errorObj.toString());
    } else if (errorObj is ForbiddenException) {
      return ErrorDetails.forbidden(errorObj.toString());
    } else if (errorObj is NotFoundException) {
      return ErrorDetails.notFound(errorObj.toString());
    } else if (errorObj is ServerException) {
      return ErrorDetails.server(errorObj.toString());
    } else if (errorObj is ServiceUnavailableException) {
      return ErrorDetails.serviceUnavailable(errorObj.toString());
    } else if (errorObj is ConflictException) {
      return ErrorDetails.conflict(errorObj.toString());
    } else if (errorObj is String) {
      return ErrorDetails.custom(message: errorObj);
    } else {
      return ErrorDetails.unknown();
    }
  }

  // 直接のエラーオブジェクトからErrorDetailsを取得
  ErrorDetails _getErrorDetailsFromDirectError(dynamic errorObj) {
    if (errorObj is NetworkException) {
      return ErrorDetails.network(errorObj.toString());
    } else if (errorObj is TimeoutException) {
      return ErrorDetails.timeout(errorObj.toString());
    } else if (errorObj is UnauthorizedException) {
      return ErrorDetails.unauthorized(errorObj.toString());
    } else if (errorObj is ForbiddenException) {
      return ErrorDetails.forbidden(errorObj.toString());
    } else if (errorObj is NotFoundException) {
      return ErrorDetails.notFound(errorObj.toString());
    } else if (errorObj is ServerException) {
      return ErrorDetails.server(errorObj.toString());
    } else if (errorObj is ServiceUnavailableException) {
      return ErrorDetails.serviceUnavailable(errorObj.toString());
    } else if (errorObj is ConflictException) {
      return ErrorDetails.conflict(errorObj.toString());
    } else {
      return ErrorDetails.unknown();
    }
  }
}

// エラー詳細情報をカプセル化するクラス
class ErrorDetails {
  final IconData icon;
  final String title;
  final String message;

  const ErrorDetails({
    required this.icon,
    required this.title,
    required this.message,
  });

  // ネットワークエラー
  factory ErrorDetails.network(String? message) {
    return ErrorDetails(
      icon: Icons.wifi_off,
      title: 'ネットワークエラー',
      message: message ??
          'インターネット接続を確認してください。Wi-Fiまたはモバイルデータ通信がオンになっていることを確認してください。',
    );
  }

  // タイムアウトエラー
  factory ErrorDetails.timeout(String? message) {
    return ErrorDetails(
      icon: Icons.timer_off,
      title: 'タイムアウトエラー',
      message: message ?? 'サーバーからの応答に時間がかかっています。時間をおいて再度お試しください。',
    );
  }

  // 認証エラー
  factory ErrorDetails.unauthorized(String? message) {
    return ErrorDetails(
      icon: Icons.lock,
      title: '認証エラー',
      message: message ?? '認証に失敗しました。再度ログインしてください。',
    );
  }

  // アクセス権限エラー
  factory ErrorDetails.forbidden(String? message) {
    return ErrorDetails(
      icon: Icons.lock,
      title: 'アクセス権限エラー',
      message: message ?? 'このコンテンツにアクセスする権限がありません。',
    );
  }

  // リソース未発見エラー
  factory ErrorDetails.notFound(String? message) {
    return ErrorDetails(
      icon: Icons.search_off,
      title: 'リソースが見つかりません',
      message: message ?? '要求されたリソースが見つかりませんでした。',
    );
  }

  // サーバーエラー
  factory ErrorDetails.server(String? message) {
    return ErrorDetails(
      icon: Icons.cloud_off,
      title: 'サーバーエラー',
      message: message ?? 'サーバーで問題が発生しています。時間をおいて再度お試しください。',
    );
  }

  // サービス利用不可エラー
  factory ErrorDetails.serviceUnavailable(String? message) {
    return ErrorDetails(
      icon: Icons.cloud_off,
      title: 'サーバーエラー',
      message: message ?? 'サービスが一時的に利用できません。メンテナンス中の可能性があります。時間をおいて再度お試しください。',
    );
  }

  // データ競合エラー
  factory ErrorDetails.conflict(String? message) {
    return ErrorDetails(
      icon: Icons.warning_amber,
      title: 'データ競合エラー',
      message: message ?? 'データの競合が発生しました。最新の情報を取得してください。',
    );
  }

  // カスタムエラーメッセージ
  factory ErrorDetails.custom({required String message}) {
    return ErrorDetails(
      icon: Icons.info_outline,
      title: 'お知らせ',
      message: message,
    );
  }

  // 不明なエラー
  factory ErrorDetails.unknown() {
    return const ErrorDetails(
      icon: Icons.error_outline,
      title: 'エラーが発生しました',
      message: '予期しないエラーが発生しました。時間をおいて再度お試しください。',
    );
  }
}
