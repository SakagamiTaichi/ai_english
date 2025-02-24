import 'package:ai_english/core/components/footer.dart';
import 'package:ai_english/features/theme/providers/theme_selector_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSelectorPage extends ConsumerWidget {
  const ThemeSelectorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeSelector = ref.watch(themeNotifierProvider.notifier);
    final currentThemeMode = ref.watch(themeNotifierProvider);

    // Scaffold を追加
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Settings'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: ThemeMode.values.length,
        itemBuilder: (_, index) {
          final themeMode = ThemeMode.values[index];
          return RadioListTile<ThemeMode>(
            value: themeMode,
            groupValue: currentThemeMode.when(
              data: (themeMode) => themeMode,
              loading: () => ThemeMode.system,
              error: (error, stack) => ThemeMode.system,
            ),
            onChanged: (newTheme) => themeSelector.changeAndSave(newTheme!),
            title: Text(themeMode.name),
          );
        },
      ),
      bottomNavigationBar: footer(context),
    );
  }
}
