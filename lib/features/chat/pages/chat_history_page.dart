import 'package:ai_english/core/components/footer.dart';
import 'package:ai_english/core/utils/methods/format.dart';
import 'package:ai_english/features/chat/pages/chat_history_detail_page.dart';
import 'package:ai_english/features/chat/providers/chat_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatHistoryPage extends ConsumerWidget {
  const ChatHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(asyncChatHistoryProvider);
    final notifier = ref.read(asyncChatHistoryProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Chat History'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: notifier.filterConversations,
            ),
          ),
          Expanded(
            child: data.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) =>
                  Center(child: Text('Failed to load conversations')),
              data: (chatHistories) => ListView.builder(
                itemCount: chatHistories.length,
                itemBuilder: (context, index) {
                  final chatHistory = chatHistories[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: Text(chatHistory.title),
                      subtitle: Text(formatDate(chatHistory.created_at)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChatHistoryDetailPage(id: chatHistory.id),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: footer(context),
    );
  }
}
