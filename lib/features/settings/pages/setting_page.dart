import 'package:ai_english/core/components/footer.dart';
import 'package:ai_english/core/components/header.dart';
import 'package:ai_english/features/settings/providers/theme_selector_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSelector = ref.watch(themeNotifierProvider.notifier);
    final currentThemeMode = ref.watch(themeNotifierProvider);

    // Scaffold を追加
    return Scaffold(
      appBar: header(context),
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
                onChanged: (newTheme) => themeSelector.changeAndSave(newTheme!),
                title: Text(themeMode.name),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: footer(context),
    );
  }
}
