import 'package:ai_english/features/chat/pages/chat_page.dart';
import 'package:ai_english/features/chat/pages/chat_history_page.dart';
import 'package:ai_english/features/home/pages/home_page.dart';
import 'package:ai_english/features/theme/pages/theme_selector_page.dart';
import 'package:flutter/material.dart';

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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        IconButton(
          tooltip: 'New Chat',
          icon: const Icon(Icons.chat),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatPage()),
            );
          },
        ),
        IconButton(
          tooltip: 'Chat History',
          icon: const Icon(Icons.history),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatHistoryPage()),
            );
          },
        ),
        IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThemeSelectorPage()),
              );
            })
      ],
    ),
  );
}
