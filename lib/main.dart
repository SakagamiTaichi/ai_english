import 'package:ai_english/core/theme/app_theme.dart'; // 追加：テーマファイルをインポート
import 'package:ai_english/features/auth/components/auth_guard.dart';
import 'package:ai_english/features/auth/pages/sign_in_page.dart';
import 'package:ai_english/features/auth/providers/auth_provider.dart';
import 'package:ai_english/features/practice/pages/chat_history_page.dart';
import 'package:ai_english/features/settings/providers/theme_selector_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return MaterialApp(
      title: 'AI English',
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
          ? const AuthGuard(child: ChatHistoryPage())
          : const SignInPage(),
    );
  }
}
