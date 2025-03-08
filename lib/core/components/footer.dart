import 'dart:math' as math;
import 'package:ai_english/core/theme/app_theme.dart';
import 'package:ai_english/features/chat/pages/chat_history_page.dart';
import 'package:ai_english/features/home/pages/home_page.dart';
import 'package:ai_english/features/settings/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Widget footer(BuildContext context) {
  final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final Color backgroundColor =
      isDarkMode ? AppTheme.backgroundDark : AppTheme.backgroundLight;
  final Color primaryColor = Theme.of(context).primaryColor;
  final Color inactiveIconColor = isDarkMode ? Colors.white54 : Colors.grey;

  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: <Widget>[
      // Main bottom bar with curved shape
      PhysicalShape(
        color: backgroundColor, // AppThemeから背景色を使用
        elevation: 16.0,
        clipper: TabClipper(radius: 38.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 62,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _buildTabIcon(
                        context,
                        Icons.history,
                        'カード一覧',
                        context.widget is ChatHistoryPage,
                        () {
                          if (context.widget is ChatHistoryPage) return;
                          Navigator.push(
                            context,
                            PageTransition(
                              child: ChatHistoryPage(),
                              type: PageTransitionType.fade,
                            ),
                          );
                        },
                        primaryColor,
                        inactiveIconColor, // アクティブでないアイコンの色を追加
                      ),
                    ),
                    Expanded(
                      child: _buildTabIcon(
                        context,
                        Icons.home,
                        'ダッシュボード',
                        context.widget is HomePage,
                        () {
                          if (context.widget is HomePage) return;
                          Navigator.push(
                            context,
                            PageTransition(
                              child: HomePage(),
                              type: PageTransitionType.fade,
                            ),
                          );
                        },
                        primaryColor,
                        inactiveIconColor, // アクティブでないアイコンの色を追加
                      ),
                    ),
                    // Center space for floating button
                    const SizedBox(width: 64.0),
                    Expanded(
                      child: _buildTabIcon(
                        context,
                        Icons.settings,
                        '設定',
                        context.widget is SettingPage,
                        () {
                          if (context.widget is SettingPage) return;
                          Navigator.push(
                            context,
                            PageTransition(
                              child: SettingPage(),
                              type: PageTransitionType.fade,
                            ),
                          );
                        },
                        primaryColor,
                        inactiveIconColor, // アクティブでないアイコンの色を追加
                      ),
                    ),
                    // Empty space to balance the layout
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),

      // Center floating button
      Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: SizedBox(
          width: 38 * 2.0,
          height: 38 + 62.0,
          child: Container(
            alignment: Alignment.topCenter,
            color: Colors.transparent,
            child: SizedBox(
              width: 38 * 2.0,
              height: 38 * 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    gradient: LinearGradient(
                      transform: GradientRotation(math.pi / 4),
                      colors: [
                        primaryColor,
                        isDarkMode
                            ? AppTheme.primaryDark.withAlpha(100)
                            : AppTheme.primaryLight.withAlpha(100),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: isDarkMode
                            ? AppTheme.primaryDark.withAlpha(100)
                            : AppTheme.primary.withAlpha(100),
                        offset: const Offset(8.0, 14.0),
                        blurRadius: 19.0,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Icon(
                      Icons.add,
                      color: AppTheme.textPrimaryDark, // 常に白色を使用
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

// Helper method to build tab icons - inactive color parameter added
Widget _buildTabIcon(
    BuildContext context,
    IconData icon,
    String tooltip,
    bool isSelected,
    VoidCallback onTap,
    Color activeColor,
    Color inactiveColor) {
  return AspectRatio(
    aspectRatio: 1,
    child: Center(
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: onTap,
        child: Tooltip(
          message: tooltip,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Icon(
                icon,
                color: isSelected ? activeColor : inactiveColor,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// Custom clipper for the curved shape
class TabClipper extends CustomClipper<Path> {
  TabClipper({this.radius = 38.0});

  final double radius;

  @override
  Path getClip(Size size) {
    final Path path = Path();

    final double v = radius * 2;
    path.lineTo(0, 0);
    path.arcTo(Rect.fromLTWH(0, 0, radius, radius), degreeToRadians(180),
        degreeToRadians(90), false);
    path.arcTo(
        Rect.fromLTWH(
            ((size.width / 2) - v / 2) - radius + v * 0.04, 0, radius, radius),
        degreeToRadians(270),
        degreeToRadians(70),
        false);

    path.arcTo(Rect.fromLTWH((size.width / 2) - v / 2, -v / 2, v, v),
        degreeToRadians(160), degreeToRadians(-140), false);

    path.arcTo(
        Rect.fromLTWH((size.width - ((size.width / 2) - v / 2)) - v * 0.04, 0,
            radius, radius),
        degreeToRadians(200),
        degreeToRadians(70),
        false);
    path.arcTo(Rect.fromLTWH(size.width - radius, 0, radius, radius),
        degreeToRadians(270), degreeToRadians(90), false);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TabClipper oldClipper) => true;

  double degreeToRadians(double degree) {
    final double redian = (math.pi / 180) * degree;
    return redian;
  }
}
