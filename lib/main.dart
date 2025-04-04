import 'dart:async';
import 'package:ai_english/core/theme/app_theme.dart';
import 'package:ai_english/core/utils/services/deelink_service.dart';
import 'package:ai_english/core/utils/services/notification_service.dart';
import 'package:ai_english/features/auth/components/auth_guard.dart';
import 'package:ai_english/features/auth/pages/sign_in_page.dart';
import 'package:ai_english/features/auth/providers/auth_provider.dart';
import 'package:ai_english/features/practice/pages/conversations_page.dart';
import 'package:ai_english/features/settings/providers/theme_selector_provider.dart';
import 'package:ai_english/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await runZonedGuarded(() async {
    // Flutterエンジンの初期化
    WidgetsFlutterBinding.ensureInitialized();

    // Firebaseの初期化
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // 通知サービスの初期化
    await NotificationService().initialize();
    // ディープリンクサービスの初期化
    await DeepLinkService().initialize();
    // アプリの実行
    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );

    //FlutterでCatchされるエラー（UIレンダリングや状態管理に関連するエラーUIレンダリングや状態管理に関連するエラ）
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }, (error, stackTrace) {
    // DartでCatchされるエラー（非同期処理や低レベルDartコードのエラー）
    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason: 'Uncaught error in main()',
    );
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return MaterialApp(
      title: '英GOAT',
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ja', 'JP'),
      ],
      // カスタムテーマを適用
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ref.watch(themeNotifierProvider).when(
            data: (themeMode) => themeMode,
            loading: () => ThemeMode.system,
            error: (error, stack) => ThemeMode.system,
          ),
      home: authState.isAuthenticated
          ? const AuthGuard(child: ConversationsPage())
          : const SignInPage(),
    );
  }
}
