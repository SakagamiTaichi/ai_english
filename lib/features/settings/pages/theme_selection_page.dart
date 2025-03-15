import 'package:ai_english/core/components/header.dart';
import 'package:ai_english/features/settings/providers/theme_selector_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSelectionPage extends ConsumerWidget {
  const ThemeSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSelector = ref.watch(themeNotifierProvider.notifier);
    final currentThemeMode = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: header(context, isDisplayBackButton: true),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: ThemeMode.values.length,
        itemBuilder: (_, index) {
          final themeMode = ThemeMode.values[index];
          return Column(
            children: [
              RadioListTile<ThemeMode>(
                value: themeMode,
                groupValue: currentThemeMode.when(
                  data: (themeMode) => themeMode,
                  loading: () => ThemeMode.system,
                  error: (error, stack) => ThemeMode.system,
                ),
                onChanged: (newTheme) {
                  themeSelector.changeAndSave(newTheme!);
                  // Optional: You could add a snackbar confirmation
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${newTheme.name}に変更されました。'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                title: Text(_getThemeDisplayName(themeMode)),
                subtitle: Text(_getThemeDescription(themeMode)),
              ),
              if (index < ThemeMode.values.length - 1)
                const Divider(indent: 16, endIndent: 16),
            ],
          );
        },
      ),
    );
  }

  String _getThemeDisplayName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  String _getThemeDescription(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'システム設定に従う';
      case ThemeMode.light:
        return 'ライトテーマを適用';
      case ThemeMode.dark:
        return 'ダークテーマを適用';
    }
  }
}
