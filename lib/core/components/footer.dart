import 'dart:math' as math;
import 'package:ai_english/core/theme/app_theme.dart';
import 'package:ai_english/features/practice/pages/conversations_page.dart';
import 'package:ai_english/features/dashboard/pages/dashboard_page.dart';
import 'package:ai_english/features/settings/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Widget footer(BuildContext context, bool isDisplayPlus) {
  final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final Color backgroundColor =
      isDarkMode ? AppTheme.backgroundDarkColor : AppTheme.backgroundColor;
  final Color primaryColor = Theme.of(context).primaryColor;
  final Color inactiveIconColor = isDarkMode ? Colors.white54 : Colors.grey;

  return Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: <Widget>[
      // Main bottom bar with flat shape
      PhysicalShape(
        color: backgroundColor,
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
                        Icons.home,
                        'ダッシュボード',
                        context.widget is DashboardPage,
                        () {
                          if (context.widget is DashboardPage) return;
                          Navigator.push(
                            context,
                            PageTransition(
                              child: DashboardPage(),
                              type: PageTransitionType.fade,
                            ),
                          );
                        },
                        primaryColor,
                        inactiveIconColor,
                      ),
                    ),
                    Expanded(
                      child: _buildTabIcon(
                        context,
                        Icons.history,
                        'カード一覧',
                        context.widget is ConversationsPage,
                        () {
                          if (context.widget is ConversationsPage) return;
                          Navigator.push(
                            context,
                            PageTransition(
                              child: ConversationsPage(),
                              type: PageTransitionType.fade,
                            ),
                          );
                        },
                        primaryColor,
                        inactiveIconColor,
                      ),
                    ),
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
                        inactiveIconColor,
                      ),
                    ),
                    // 4つ目のスペースは必要に応じて他のアイコンを追加するか、削除してください
                    Expanded(
                      child: SizedBox(),
                    ),
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
                size: 32,
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

    // 左上の角を丸くする
    path.lineTo(0, 0);
    path.arcTo(Rect.fromLTWH(0, 0, radius, radius), degreeToRadians(180),
        degreeToRadians(90), false);

    // 上辺を描く (左から右へ)
    path.lineTo(size.width - radius, 0);

    // 右上の角を丸くする
    path.arcTo(Rect.fromLTWH(size.width - radius, 0, radius, radius),
        degreeToRadians(270), degreeToRadians(90), false);

    // 右辺、下辺、左辺を描く
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

@override
bool shouldReclip(TabClipper oldClipper) => true;

double degreeToRadians(double degree) {
  final double redian = (math.pi / 180) * degree;
  return redian;
}
