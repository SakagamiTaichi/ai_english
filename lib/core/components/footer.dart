import 'package:ai_english/features/chat/pages/chat_page.dart';
import 'package:ai_english/features/chat/pages/chat_history_page.dart';
import 'package:ai_english/features/home/pages/home_page.dart';
import 'package:ai_english/features/theme/pages/theme_selector_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Widget footer(BuildContext context) {
  return BottomAppBar(
    elevation: 1,
    height: MediaQuery.of(context).size.height * 0.08,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          tooltip: 'Home',
          icon: const Icon(Icons.home),
          color: context.widget is HomePage
              ? Theme.of(context).primaryColor
              : null,
          onPressed: () {
            if (context.widget is HomePage) return;
            Navigator.push(
              context,
              PageTransition(
                child: HomePage(), //画面遷移先
                type: PageTransitionType.leftToRightWithFade, //アニメーションの種類
              ),
            );
          },
        ),
        IconButton(
          tooltip: 'New Chat',
          icon: const Icon(Icons.chat),
          color: context.widget is ChatPage
              ? Theme.of(context).primaryColor
              : null,
          onPressed: () {
            if (context.widget is ChatPage) return;
            Navigator.push(
              context,
              PageTransition(
                child: ChatPage(), //画面遷移先
                type: PageTransitionType.leftToRightWithFade, //アニメーションの種類
              ),
            );
          },
        ),
        IconButton(
          tooltip: 'Chat History',
          icon: const Icon(Icons.history),
          color: context.widget is ChatHistoryPage
              ? Theme.of(context).primaryColor
              : null,
          onPressed: () {
            if (context.widget is ChatHistoryPage) return;
            Navigator.push(
                context,
                PageTransition(
                  child: ChatHistoryPage(), //画面遷移先
                  type: PageTransitionType.leftToRightWithFade, //アニメーションの種類
                ));
          },
        ),
        IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings),
            color: context.widget is ThemeSelectorPage
                ? Theme.of(context).primaryColor
                : null,
            onPressed: () {
              if (context.widget is ThemeSelectorPage) return;
              Navigator.push(
                  context,
                  PageTransition(
                    child: ThemeSelectorPage(), //画面遷移先
                    type: PageTransitionType.leftToRightWithFade, //アニメーションの種類
                  ));
            })
      ],
    ),
  );
}
