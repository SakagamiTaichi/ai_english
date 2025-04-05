import 'package:ai_english/core/utils/methods/format.dart';
import 'package:ai_english/features/practice/models/conversations.dart';
import 'package:ai_english/features/practice/pages/conversation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:page_transition/page_transition.dart';

Widget conversationListItem({
  required ConversationsResponse conversationsResponse,
  required Function(int oldIndex, int newIndex) onReorder,
}) {
  return AnimationLimiter(
    child: ReorderableListView.builder(
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
        return AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            return Material(
              elevation: 5.0,
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12.0),
              child: child,
            );
          },
          child: child,
        );
      },
      itemBuilder: (context, index) {
        final chatHistory = conversationsResponse.conversations[index];

        return AnimationConfiguration.staggeredList(
          key: ValueKey(chatHistory.id), // ReorderableListViewには一意のKeyが必要です
          position: index,
          duration: const Duration(milliseconds: 375),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Card(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.0),
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
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
              ),
            ),
          ),
        );
      },
    ),
  );
}
