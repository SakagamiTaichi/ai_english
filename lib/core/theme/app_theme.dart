import 'package:flutter/material.dart';

/// アプリケーションのテーマ設定を管理するクラス
class AppTheme {
  // プライマリカラー
  static const Color primary = Color.fromARGB(255, 255, 148, 55);
  static const Color primaryDark = Color.fromARGB(255, 230, 135, 50);
  static const Color primaryLight = Color.fromARGB(255, 255, 176, 107);

  // 背景色
  static const Color backgroundLight = Colors.white;
  static const Color backgroundDark = Color(0xFF2C2C2C);

  // カード背景色
  static const Color cardLight = Color.fromARGB(255, 255, 237, 220);
  static const Color cardDark = Color(0xFF2C2C2C);

  // テキスト色
  static const Color textPrimaryLight = Colors.black87;
  static const Color textSecondaryLight = Colors.black54;
  static const Color textPrimaryDark = Colors.white;
  static const Color textSecondaryDark = Colors.white70;

  // ライトテーマの定義
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,

    // カラースキーム
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ),

    // アイコンの色
    iconTheme: const IconThemeData(color: Colors.black87),

    // アプリバーのテーマ
    appBarTheme: const AppBarTheme(
      toolbarHeight: 46.0,
      centerTitle: true,
      elevation: 0,
      backgroundColor: primary,
      foregroundColor: Colors.white,
    ),

    // ボタンテーマ
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryLight,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),

    // テキストテーマ
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.bold, color: textPrimaryLight),
      headlineMedium: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: textPrimaryLight),
      headlineSmall: TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.bold, color: textPrimaryLight),
      titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: textPrimaryLight,
      ),
      titleMedium: TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.bold, color: textPrimaryLight),
      titleSmall: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: textSecondaryDark),
      bodyLarge: TextStyle(fontSize: 16.0, color: textPrimaryLight),
      bodyMedium: TextStyle(fontSize: 14.0, color: textSecondaryLight),
      bodySmall: TextStyle(
        fontSize: 12.0,
        color: textSecondaryLight,
      ),
    ),

    // カードテーマ
    cardTheme: const CardTheme(
      color: cardLight,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  );

  // ダークテーマの定義
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,

    // カラースキーム
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryDark,
      brightness: Brightness.dark,
    ),

    // アイコンの色
    iconTheme: const IconThemeData(color: Colors.white),

    // アプリバーのテーマ
    appBarTheme: const AppBarTheme(
      toolbarHeight: 46.0,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color(0xFF212121),
      foregroundColor: Colors.white,
    ),

    // ボタンテーマ
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryDark,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),

    // テキストテーマ
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: textPrimaryDark,
      ),
      headlineMedium: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: textPrimaryDark,
      ),
      headlineSmall: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: textPrimaryDark,
      ),
      titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: textPrimaryDark,
      ),
      titleMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: textPrimaryDark,
      ),
      titleSmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: textSecondaryDark,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        color: textPrimaryDark,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        color: textSecondaryDark,
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        color: textSecondaryDark,
      ),
    ),

    // カードテーマ
    cardTheme: const CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      color: cardDark,
    ),
  );
}
