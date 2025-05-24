import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
// Import the main.dart file for the navigatorKey
// Import the EmailVerificationCompletePage (adjust the path as needed)

class DeepLinkService {
  static final DeepLinkService _instance = DeepLinkService._internal();
  final AppLinks _appLinks = AppLinks();

  factory DeepLinkService() {
    return _instance;
  }

  DeepLinkService._internal();

  Future<void> initialize() async {
    // 起動時のディープリンクを取得
    final Uri? initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      handleDeepLink(initialLink);
    }

    // 以降のディープリンクを監視
    _appLinks.uriLinkStream.listen((Uri uri) {
      handleDeepLink(uri);
    });
  }

  void handleDeepLink(Uri uri) {
    // ディープリンクのパスやクエリパラメータに基づいて処理
    if (kDebugMode) {
      debugPrint('ディープリンク: $uri');
    }

    // メール認証関連のディープリンクかどうかをチェック
    // 例: /verify-email というパスを含むか、emailVerified=true などのパラメータがある場合
    // 実際のアプリのディープリンク形式に合わせて条件を調整してください
    if (uri.path.contains('/verify-email') ||
        uri.queryParameters.containsKey('emailVerified')) {
      // グローバルなNavigatorKeyを使って画面遷移
      // navigatorKey.currentState?.pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => const EmailVerificationCompletePage(),
      //   ),
      // );
    }
  }
}
