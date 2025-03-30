import 'package:ai_english/features/practice/data/conversations_repository.dart';
import 'package:ai_english/features/practice/data/repository_providers.dart';
import 'package:ai_english/features/practice/models/conversations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../generated/features/practice/providers/conversations_provider.g.dart';

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
