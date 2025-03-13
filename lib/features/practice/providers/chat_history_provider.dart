import 'package:ai_english/features/practice/data/conversations_repository.dart';
import 'package:ai_english/features/practice/data/conversations_repository_provider.dart';
import 'package:ai_english/features/practice/models/chat_history.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../generated/features/practice/providers/chat_history_provider.g.dart';

@riverpod
class AsyncChatHistory extends _$AsyncChatHistory {
  late final IConversationsRepository _repository;
  List<Conversation>? _originalChatHistories;

  @override
  FutureOr<List<Conversation>> build() async {
    _repository = ref.watch(conversationsRepositoryProvider);
    return await _fetchAndStoreConversations();
  }

  Future<List<Conversation>> _fetchAndStoreConversations() async {
    final conversations = await _repository.fetchConversations();
    _originalChatHistories = conversations;
    return conversations;
  }

  void filterConversations(String keyword) {
    if (_originalChatHistories == null) return;

    if (keyword.isEmpty) {
      state = AsyncData(_originalChatHistories!);
      return;
    }

    final lowercaseKeyword = keyword.toLowerCase();
    final filteredList = _originalChatHistories!
        .where((chat) => chat.title.toLowerCase().contains(lowercaseKeyword))
        .toList();

    state = AsyncData(filteredList);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchAndStoreConversations());
  }
}
