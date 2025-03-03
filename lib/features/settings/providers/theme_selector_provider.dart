import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_selector_provider.g.dart';

const String themePrefsKey = 'theme_mode';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  Future<ThemeMode> build() async {
    // Future<ThemeMode> に変更
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(themePrefsKey);

    if (themeIndex == null) {
      return ThemeMode.system;
    }

    return ThemeMode.values.firstWhere(
      (e) => e.index == themeIndex,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> changeAndSave(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(themePrefsKey, theme.index);
    state = AsyncValue.data(theme); // AsyncValue.data() を使用
  }
}
