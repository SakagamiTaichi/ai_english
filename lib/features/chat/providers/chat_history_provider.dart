import 'package:ai_english/core/http/api_client.dart';
import 'package:ai_english/features/chat/models/chat_history.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_history_provider.g.dart';

@riverpod
class AsyncChatHistory extends _$AsyncChatHistory {
  late final ApiClient _apiClient;
  List<ChatHistory>? _originalChatHistories;

  @override
  FutureOr<List<ChatHistory>> build() async {
    _apiClient = ApiClient();
    _originalChatHistories = await _fetchConversations();
    return _originalChatHistories!;
  }

  Future<List<ChatHistory>> _fetchConversations() async {
    try {
      final response = await _apiClient.get('/english/conversation_sets');
      var data = response.data as List<dynamic>;
      return data.map((e) => ChatHistory.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
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

  // オプション: 検索をリセットするメソッド
  void resetFilter() {
    if (_originalChatHistories != null) {
      state = AsyncData(_originalChatHistories!);
    }
  }
}
