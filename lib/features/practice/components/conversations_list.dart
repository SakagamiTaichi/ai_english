import 'package:ai_english/core/utils/methods/format.dart';
import 'package:ai_english/features/practice/models/conversations.dart';
import 'package:ai_english/features/practice/pages/conversation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:page_transition/page_transition.dart';

Widget conversationListItem({
  required ConversationsResponse conversationsResponse,
}) {
  return AnimationLimiter(
    child: ListView.builder(
      itemCount: conversationsResponse.conversations.length,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        final chatHistory = conversationsResponse.conversations[index];
        // スタガード（ずらした）アニメーションの設定を行うウィジェットです
        return AnimationConfiguration.staggeredList(
          // 各項目の位置を指定し、順番にアニメーションを実行するために使用されます
          position: index,
          // 各アニメーションの持続時間を375ミリ秒に設定しています
          duration: const Duration(milliseconds: 375),
          // ウィジェットをスライドさせるアニメーションを適用します
          child: SlideAnimation(
            // 項目が50ピクセル下から上へスライドしてくる効果を作り出します
            verticalOffset: 50.0,
            // ウィジェットをフェードイン（透明から不透明へ）させるアニメーションを適用します
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
                          Text(
                            chatHistory.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.titleMedium,
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
