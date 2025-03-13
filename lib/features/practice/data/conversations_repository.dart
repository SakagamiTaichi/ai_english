import 'package:ai_english/core/http/iapi_client.dart';
import 'package:ai_english/features/practice/models/chat_history.dart';

abstract class IConversationsRepository {
  Future<List<Conversation>> fetchConversations();
}

class ConversationsRepository implements IConversationsRepository {
  final IApiClient _apiClient;

  ConversationsRepository(this._apiClient);

  @override
  Future<List<Conversation>> fetchConversations() async {
    try {
      final response = await _apiClient.get('/english/conversation_sets');
      var data = response.data as List<dynamic>;
      return data.map((e) => Conversation.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
