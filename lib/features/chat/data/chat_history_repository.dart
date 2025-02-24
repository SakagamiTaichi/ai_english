import 'package:ai_english/core/http/iapi_client.dart';
import 'package:ai_english/features/chat/models/chat_history.dart';

abstract class IChatHistoryRepository {
  Future<List<ChatHistory>> fetchConversations();
}

class ChatHistoryRepository implements IChatHistoryRepository {
  final IApiClient _apiClient;

  ChatHistoryRepository(this._apiClient);

  @override
  Future<List<ChatHistory>> fetchConversations() async {
    try {
      final response = await _apiClient.get('/english/conversation_sets');
      var data = response.data as List<dynamic>;
      return data.map((e) => ChatHistory.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
