import 'package:ai_english/core/components/footer.dart';
import 'package:ai_english/core/components/header.dart';
import 'package:ai_english/core/constans/MessageConstant.dart';
import 'package:ai_english/core/utils/methods/format.dart';
import 'package:ai_english/features/practice/pages/conversation_page.dart';
import 'package:ai_english/features/practice/pages/enjglish_recall_test_page.dart';
import 'package:ai_english/features/practice/providers/conversations_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConversationsPage extends ConsumerStatefulWidget {
  const ConversationsPage({super.key});

  @override
  ConsumerState<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends ConsumerState<ConversationsPage> {
  bool _isSearchVisible = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(conversationsNotifierProvider);
    final notifier = ref.read(conversationsNotifierProvider.notifier);

    return Scaffold(
      appBar: header(context),
      body: Column(
        children: [
          // 検索アイコンを右寄せにする
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(_isSearchVisible ? Icons.close : Icons.search),
                  onPressed: _toggleSearch,
                ),
              ],
            ),
          ),
          // 検索欄（表示・非表示の切り替え）
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _isSearchVisible ? 60 : 0,
            child: Visibility(
              visible: _isSearchVisible,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: '検索',
                    border: const OutlineInputBorder(),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    // 検索テキストがある場合のみバツアイコンを表示
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              // テキストをクリアして検索結果も更新
                              _searchController.clear();
                              notifier.filterConversations('');
                            },
                          )
                        : null,
                  ),
                  onChanged: notifier.filterConversations,
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => notifier.refresh(),
              child: data.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) =>
                    Center(child: Text(MeesageConstant.failedToLoadData)),
                data: (chatHistories) => ListView.builder(
                  itemCount: chatHistories.length,
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, index) {
                    final chatHistory = chatHistories[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Card(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12.0),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EnglishRecallTestPage(
                                  conversationId: chatHistory.id,
                                ),
                              ),
                            );
                          },
                          onLongPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ConversationPage(id: chatHistory.id),
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
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      formatDate(chatHistory.created_at),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
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
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: footer(context, true),
    );
  }
}
