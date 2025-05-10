import 'package:ai_english/core/components/error_feedback.dart';
import 'package:ai_english/core/components/footer.dart';
import 'package:ai_english/core/components/header.dart';
import 'package:ai_english/features/practice/components/ai_generate_conversation_dialog.dart';
import 'package:ai_english/features/practice/components/conversations_list.dart';
import 'package:ai_english/features/practice/components/fab_option.dart';
import 'package:ai_english/features/practice/components/fab_option_button.dart';
import 'package:ai_english/features/practice/models/conversations.dart';
import 'package:ai_english/features/practice/pages/conversation_page.dart';
import 'package:ai_english/features/practice/providers/conversations_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ConversationsPage extends ConsumerStatefulWidget {
  const ConversationsPage({super.key});

  @override
  ConsumerState<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends ConsumerState<ConversationsPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  bool _isDialOpen = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleReorder(int oldIndex, int newIndex) {
    final notifier = ref.read(conversationsNotifierProvider.notifier);
    notifier.reorderConversations(oldIndex, newIndex);
  }

  void _toggleFabOptions() {
    setState(() {
      _isDialOpen = !_isDialOpen;
      if (_isDialOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(conversationsNotifierProvider);
    final notifier = ref.read(conversationsNotifierProvider.notifier);

    // FAB options definition
    // FAB options definition
    final List<Map<String, dynamic>> fabOptions = [
      {
        'label': 'フレーズからAI生成',
        'icon': Icons.chat,
        'onTap': () async {
          _toggleFabOptions();

          // 更新したダイアログを表示
          final result = await showAiGenerateDialog(context);

          // 成功した場合は会話詳細ページに遷移
          if (result != null) {
            // 遷移先のページに必要なデータを渡す
            // await notifier.refresh();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ConversationPage(id: result), // 遷移先のページを指定
              ),
            );
          }
        },
      },
      {
        'label': 'AIとの会話から作成',
        'icon': Icons.edit,
        'onTap': () {
          _toggleFabOptions();
          // フレーズから作成の処理
        },
      },
      {
        'label': 'テンプレートを追加',
        'icon': Icons.link,
        'onTap': () {
          _toggleFabOptions();
          // テンプレートを追加の処理
        },
      },
    ];

    return Scaffold(
      appBar: header(context),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => notifier.refresh(),
                  child: data.when(
                    loading: () => Skeletonizer(
                      enabled: true,
                      enableSwitchAnimation: true,
                      child: conversationListItem(
                        conversationsResponse: ConversationsResponse(
                          conversations: [
                            for (int i = 0; i < 10; i++)
                              ConversationResponseConversation(
                                id: i.toString(),
                                title: '会話のタイトルがここに表示されます',
                                created_at: DateTime.now(),
                                order: i,
                              ),
                          ],
                        ),
                        onReorder: _handleReorder,
                      ),
                    ),
                    error: (error, _) => ErrorFeedback(
                      error: error,
                      onRetry: () => notifier.refresh(),
                    ),
                    data: (conversationsResponse) => conversationListItem(
                      conversationsResponse: conversationsResponse,
                      onReorder: _handleReorder,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_isDialOpen)
            AnimatedOpacity(
              opacity: _isDialOpen ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 250),
              child: GestureDetector(
                onTap: () {
                  _toggleFabOptions();
                },
                child: Container(
                  color: Colors.black54,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          if (_isDialOpen)
            Positioned(
              right: 16,
              bottom: 80,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (int i = 0; i < fabOptions.length; i++) ...[
                    AnimationConfiguration.staggeredList(
                      position: fabOptions.length - 1 - i,
                      duration: const Duration(milliseconds: 275),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: fabOption(
                            context: context,
                            label: fabOptions[i]['label'],
                            icon: fabOptions[i]['icon'],
                            onTap: fabOptions[i]['onTap'],
                          ),
                        ),
                      ),
                    ),
                    if (i < fabOptions.length - 1) const SizedBox(height: 16),
                  ],
                ],
              ),
            )
        ],
      ),
      floatingActionButton: fabOptionButton(
        context: context,
        isDialOpen: _isDialOpen,
        toggleFabOptions: _toggleFabOptions,
      ),
      bottomNavigationBar: footer(context, true),
    );
  }
}
