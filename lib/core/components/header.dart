import 'package:flutter/material.dart';

/// 共通ヘッダーコンポーネント
/// isDisplayBackButton: 戻るボタンを表示するかどうか
/// isDisplaySideMenuButton: サイドメニューボタンを表示するかどうか
/// onPlayAll: サイドメニューの「全再生」ボタンの処理
/// showPlayAllButton: 「全再生」ボタンを表示するかどうか
/// showSpeedControl: 速度コントロールを表示するかどうか
/// scaffoldKey: ScaffoldのGlobalKeyを指定すると、サイドメニューを開くことができます
PreferredSizeWidget header(
  BuildContext context, {
  bool isDisplayBackButton = false,
  bool isDisplaySideMenuButton = false,
  VoidCallback? onPlayAll,
  bool showPlayAllButton = true,
  bool showSpeedControl = true,
  GlobalKey<ScaffoldState>? scaffoldKey,
}) {
  return AppBar(
    toolbarHeight: Theme.of(context).appBarTheme.toolbarHeight,
    automaticallyImplyLeading: isDisplayBackButton,
    foregroundColor: Theme.of(context).colorScheme.primary,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor, // 半透明の背景色を設定
    // スクロール時にヘッダーの色が濃くなる問題を修正
    scrolledUnderElevation: 0, // スクロール時に影やティントを無効化
    surfaceTintColor: Colors.transparent, // M3のティント効果を無効化
    elevation: 0, // 影を無効化
    actions: isDisplaySideMenuButton
        ? [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // scaffoldKeyが渡されている場合はそれを使用
                if (scaffoldKey != null) {
                  scaffoldKey.currentState?.openEndDrawer();
                }
              },
            ),
          ]
        : null,
  );
}
