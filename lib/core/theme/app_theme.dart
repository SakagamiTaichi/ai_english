import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// アプリケーションのテーマ設定を管理するクラス
class AppTheme {
  // プライマリカラー
  static const Color primary = Color.fromARGB(255, 255, 148, 55);
  static const Color primaryDark = Color.fromARGB(255, 230, 135, 50);
  static const Color primaryLight = Color.fromARGB(255, 255, 176, 107);

  static const Color backgroundColor = Colors.white;
  static const Color backgroundDarkColor = Color(0xFF2C2C2C);

  // 背景色2
  static const Color backgroundLight = Color.fromARGB(255, 252, 246, 240);
  static const Color backgroundDark = Color(0xFF3C3C3C);

  // カード背景色
  // static const Color cardLight = Color.fromARGB(255, 255, 237, 220);
  static const Color cardLight = Colors.white;
  static const Color cardDark = Color(0xFF2C2C2C);

  // テキスト色
  static const Color textPrimaryLight = Colors.black87;
  static const Color textSecondaryLight = Colors.black54;
  static const Color textPrimaryDark = Colors.white;
  static const Color textSecondaryDark = Colors.white70;

  // メッセージバブルの色
  static const Color messageBubbleRightLight = Color.fromARGB(255, 231, 113, 3);
  static const Color messageBubbleRightDark = Color(0xFF2C2C2C);
  static const Color messageBubbleLeftLight = Colors.grey;
  static const Color messageBubbleLeftDark = Color(0xFF2C2C2C);

  // ライトテーマの定義
  static ThemeData lightTheme = ThemeData(
    // fontFamily: GoogleFonts.notoSansJavaneseTextTheme().fontFamily, // フォントの設定

    brightness: Brightness.light,
    useMaterial3: true,

    // カラースキーム
    colorScheme: ColorScheme.fromSeed(
      primary: primary,
      inversePrimary: backgroundColor,
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
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      ),
    ),

    scaffoldBackgroundColor: backgroundLight,

    primaryTextTheme: GoogleFonts.kosugiMaruTextTheme(
      const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: textPrimaryLight,
        ),
      ),
    ),

    textTheme: GoogleFonts.kosugiMaruTextTheme(const TextTheme(
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
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: textPrimaryLight),
      titleSmall: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          color: textSecondaryLight),
      bodyLarge: TextStyle(fontSize: 16.0, color: textPrimaryLight),
      bodyMedium: TextStyle(fontSize: 14.0, color: textSecondaryLight),
      bodySmall: TextStyle(
        fontSize: 12.0,
        color: textSecondaryLight,
      ),
    )),

    // カードテーマ
    cardTheme: CardTheme(
      color: cardLight,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: 20,
          cornerSmoothing: 0.1,
        ),
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
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    ),

    primaryTextTheme: GoogleFonts.kosugiMaruTextTheme(
      const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: textPrimaryDark,
        ),
      ),
    ),

    // テキストテーマ
    textTheme: GoogleFonts.kosugiMaruTextTheme(const TextTheme(
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
        fontWeight: FontWeight.normal,
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
    )),

    // カードテーマ
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: 20,
          cornerSmoothing: 0.1,
        ),
      ),
      color: cardDark,
    ),
  );
}
