import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';

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
  }
}
