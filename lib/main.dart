import 'package:ai_english/features/auth/components/auth_guard.dart';
import 'package:ai_english/features/auth/pages/sign_in_page.dart';
import 'package:ai_english/features/auth/providers/auth_provider.dart';
import 'package:ai_english/features/home/pages/home_page.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return MaterialApp(
      title: 'AI English',
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('ja', 'JP'),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 148, 55)),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ref.watch(themeNotifierProvider).when(
            data: (themeMode) => themeMode,
            loading: () => ThemeMode.system,
            error: (error, stack) => ThemeMode.system,
          ),
      home: authState.isAuthenticated
          ? const AuthGuard(child: HomePage())
          : const SignInPage(),
    );
  }
}
