import 'dart:async';

import 'package:ai_english/features/practice/data/conversations_repository.dart';
import 'package:ai_english/features/practice/data/repository_providers.dart';
import 'package:ai_english/features/practice/models/conversations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../generated/features/practice/providers/conversations_provider.g.dart';

Timer? _debounceTimer;

@riverpod
class ConversationsNotifier extends _$ConversationsNotifier {
  late final IConversationsRepository _repository;
  ConversationsResponse? _originalChatHistories;

  @override
  FutureOr<ConversationsResponse> build() async {
    _repository = ref.watch(conversationsRepositoryProvider);
    return await _fetchAndStoreConversations();
  }

  Future<ConversationsResponse> _fetchAndStoreConversations() async {
    try {
      final conversations = await _repository.fetchConversations();

      final sortedConversations = List<ConversationResponseConversation>.from(
          conversations.conversations);
      sortedConversations.sort((a, b) => a.order.compareTo(b.order));

      // 並び替えたリストを新しいレスポンスオブジェクトに設定
      final sortedConversationsResponse = conversations.copyWith(
        conversations: sortedConversations,
      );

      _originalChatHistories = sortedConversationsResponse;
      return sortedConversationsResponse;
    } catch (e) {
      rethrow;
    }
  }

  void reorderConversations(int oldIndex, int newIndex) {
    state.whenData((conversationsResponse) {
      final conversations = [...conversationsResponse.conversations];
      final item = conversations.removeAt(oldIndex);
      conversations.insert(newIndex, item);

      // 新しいレスポンスオブジェクトを作成
      final updatedResponse = ConversationsResponse(
        conversations: conversations,
        // 他の必要なフィールドがあれば追加
      );

      // 状態を更新
      state = AsyncData(updatedResponse);
      // デバウンス処理: 前回のタイマーをキャンセルして新しいタイマーを設定
      _debounceTimer?.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 1000), () {
        _repository
            .reorderConversations(conversations.map((e) => e.id).toList());
      });
      // 並び替えを保存する
    });
  }

  void filterConversations(String keyword) {
    if (_originalChatHistories == null) return;

    if (keyword.isEmpty) {
      state = AsyncData(_originalChatHistories!);
      return;
    }

    final lowercaseKeyword = keyword.toLowerCase();

    final filteredList = _originalChatHistories!.conversations
        .where((chat) => chat.title.toLowerCase().contains(lowercaseKeyword))
        .toList();

    final filteredConversationsResponse = _originalChatHistories!.copyWith(
      conversations: filteredList,
    );
    state = AsyncData(filteredConversationsResponse);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchAndStoreConversations());
  }
}
