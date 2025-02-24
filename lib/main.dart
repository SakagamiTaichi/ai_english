import 'package:ai_english/features/home/pages/home_page.dart';
import 'package:ai_english/features/theme/providers/theme_selector_provider.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: HomePage(),
    );
  }
}
