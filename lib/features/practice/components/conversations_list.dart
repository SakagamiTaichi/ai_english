import 'package:ai_english/core/utils/methods/format.dart';
import 'package:ai_english/features/practice/models/conversations.dart';
import 'package:ai_english/features/practice/pages/conversation_page.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Widget conversationListItem({
  required ConversationsResponse conversationsResponse,
  required Function(int oldIndex, int newIndex) onReorder,
}) {
  return ReorderableListView.builder(
    itemCount: conversationsResponse.conversations.length,
    padding: const EdgeInsets.all(16.0),
    onReorder: (oldIndex, newIndex) {
      // ReorderableListViewの仕様により、移動先のインデックスを調整する必要があります
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      onReorder(oldIndex, newIndex);
    },
    proxyDecorator: (child, index, animation) {
      return child;
    },
    itemBuilder: (context, index) {
      final chatHistory = conversationsResponse.conversations[index];

      return Padding(
        key: ValueKey(chatHistory.id),
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Card(
          child: InkWell(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 20,
              cornerSmoothing: 0.1,
            ),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: ConversationPage(id: chatHistory.id),
                  type: PageTransitionType.rightToLeft,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chatHistory.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDate(chatHistory.created_at),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
