import 'package:ai_english/core/components/footer.dart';
import 'package:ai_english/core/components/header.dart';
import 'package:ai_english/core/constans/MessageConstant.dart';
import 'package:ai_english/features/practice/components/conversations_list.dart';
import 'package:ai_english/features/practice/providers/conversations_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConversationsPage extends ConsumerStatefulWidget {
  const ConversationsPage({super.key});

  @override
  ConsumerState<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends ConsumerState<ConversationsPage>
    with SingleTickerProviderStateMixin {
  // bool _isSearchVisible = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleReorder(int oldIndex, int newIndex) {
    // 並び替え処理をNotifierに委譲
    final notifier = ref.read(conversationsNotifierProvider.notifier);
    notifier.reorderConversations(oldIndex, newIndex);

    // 必要に応じてバックエンドに並び替え情報を保存
    // notifier.saveConversationsOrder();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(conversationsNotifierProvider);
    final notifier = ref.read(conversationsNotifierProvider.notifier);

    return Scaffold(
      appBar: header(context),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => notifier.refresh(),
              child: data.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) =>
                    Center(child: Text(MeesageConstant.failedToLoadData)),
                data: (conversationsResponse) => conversationListItem(
                  conversationsResponse: conversationsResponse,
                  onReorder: _handleReorder, // 新しいパラメータを追加
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
