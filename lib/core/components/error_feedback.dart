import 'package:ai_english/core/http/interceptors/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

// 共通のエラーハンドリングユーティリティクラス
class ErrorHandlingUtil {
  // エラータイプを判別してErrorDetailsを返す
  static ErrorDetails getErrorDetails(dynamic error) {
    // DioExceptionの場合は中のエラーを抽出
    if (error is DioException) {
      final innerError = error.error;
      return _classifyError(innerError);
    }

    // 直接例外オブジェクトの場合
    return _classifyError(error);
  }

  // エラーを分類してErrorDetailsを返す
  static ErrorDetails _classifyError(dynamic errorObj) {
    if (errorObj is NetworkException) {
      return ErrorDetails.network();
    } else if (errorObj is BadRequestException) {
      return ErrorDetails.badReqest(errorObj.message);
    } else if (errorObj is TimeoutException) {
      return ErrorDetails.timeout(errorObj.message);
    } else if (errorObj is UnauthorizedException) {
      return ErrorDetails.unauthorized(errorObj.message);
    } else if (errorObj is ForbiddenException) {
      return ErrorDetails.forbidden(errorObj.message);
    } else if (errorObj is NotFoundException) {
      return ErrorDetails.notFound(errorObj.message);
    } else if (errorObj is ServerException) {
      return ErrorDetails.server(errorObj.message);
    } else if (errorObj is ServiceUnavailableException) {
      return ErrorDetails.serviceUnavailable(errorObj.message);
    } else if (errorObj is ConflictException) {
      return ErrorDetails.conflict(errorObj.message);
    } else {
      return ErrorDetails.unknown();
    }
  }

  // エラーメッセージのみを取得する
  static String getErrorMessage(dynamic error) {
    return getErrorDetails(error).message;
  }
}

class ApiOperationWrapper {
  /// API操作を実行し、エラーを適切に処理するラッパー関数
  static Future<T?> execute<T>({
    required Future<T> Function() operation,
    required BuildContext context,
    required String successMessage,
    VoidCallback? onSuccess,
  }) async {
    try {
      final result = await operation();
      if (onSuccess != null) {
        onSuccess();
      }

      // 成功メッセージを表示
      if (successMessage.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(successMessage),
            backgroundColor: Colors.lightGreen,
            duration: const Duration(seconds: 3),
          ),
        );
      }

      return result;
    } catch (e) {
      // 共通ユーティリティを使用してエラーメッセージを取得
      String errorMessage = ErrorHandlingUtil.getErrorMessage(e);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: Text(errorMessage),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
        ),
      );

      return null;
    }
  }
}

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
    // 共通ユーティリティを使用してエラー情報を取得
    final errorDetails = ErrorHandlingUtil.getErrorDetails(error);

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
}

// エラー詳細情報をカプセル化するクラス（変更なし）
class ErrorDetails {
  final IconData icon;
  final String title;
  final String message;

  const ErrorDetails({
    required this.icon,
    required this.title,
    required this.message,
  });

  // ファクトリーメソッド（変更なし）
  factory ErrorDetails.network() {
    return ErrorDetails(
      icon: Icons.wifi_off,
      title: 'ネットワークエラー',
      message: 'インターネット接続を確認してください。Wi-Fiまたはモバイルデータ通信がオンになっていることを確認してください。',
    );
  }

  factory ErrorDetails.timeout(String? message) {
    return ErrorDetails(
      icon: Icons.timer_off,
      title: 'タイムアウトエラー',
      message: message ?? 'サーバーからの応答に時間がかかっています。時間をおいて再度お試しください。',
    );
  }

  factory ErrorDetails.unauthorized(String? message) {
    return ErrorDetails(
      icon: Icons.lock,
      title: '認証エラー',
      message: message ?? '認証に失敗しました。再度ログインしてください。',
    );
  }

  factory ErrorDetails.forbidden(String? message) {
    return ErrorDetails(
      icon: Icons.lock,
      title: 'アクセス権限エラー',
      message: message ?? 'このコンテンツにアクセスする権限がありません。',
    );
  }

  factory ErrorDetails.notFound(String? message) {
    return ErrorDetails(
      icon: Icons.search_off,
      title: 'リソースが見つかりません',
      message: message ?? '要求されたリソースが見つかりませんでした。',
    );
  }

  factory ErrorDetails.server(String? message) {
    return ErrorDetails(
      icon: Icons.cloud_off,
      title: 'サーバーエラー',
      message: message ?? 'サーバーで問題が発生しています。時間をおいて再度お試しください。',
    );
  }

  factory ErrorDetails.serviceUnavailable(String? message) {
    return ErrorDetails(
      icon: Icons.cloud_off,
      title: 'サーバーエラー',
      message: message ?? 'サービスが一時的に利用できません。メンテナンス中の可能性があります。時間をおいて再度お試しください。',
    );
  }

  factory ErrorDetails.conflict(String? message) {
    return ErrorDetails(
      icon: Icons.warning_amber,
      title: 'データ競合エラー',
      message: message ?? 'データの競合が発生しました。最新の情報を取得してください。',
    );
  }

  factory ErrorDetails.badReqest(String? message) {
    return ErrorDetails(
      icon: Icons.info_outline,
      title: 'リクエストエラー',
      message: message ?? 'リクエストに問題があります。入力内容を確認してください。',
    );
  }

  factory ErrorDetails.unknown() {
    return const ErrorDetails(
      icon: Icons.error_outline,
      title: 'エラーが発生しました',
      message: '予期しないエラーが発生しました。時間をおいて再度お試しください。',
    );
  }
}
