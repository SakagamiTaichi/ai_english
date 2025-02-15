import 'package:ai_english/features/chat/pages/chat_page.dart';
import 'package:flutter/material.dart';

Widget footer(BuildContext context) {
  return BottomAppBar(
    elevation: 1,
    height: MediaQuery.of(context).size.height * 0.08,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
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
      ],
    ),
  );
}
