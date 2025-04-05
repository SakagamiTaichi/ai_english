import 'package:ai_english/core/http/iapi_client.dart';
import 'package:ai_english/features/practice/models/conversations.dart';

abstract class IConversationsRepository {
  Future<ConversationsResponse> fetchConversations();
  Future<void> reorderConversations(List<String> ids);
}

class ConversationsRepository implements IConversationsRepository {
  final IApiClient _apiClient;

  ConversationsRepository(this._apiClient);

  @override
  Future<ConversationsResponse> fetchConversations() async {
    try {
      final response = await _apiClient.get('/practice/conversations');

      return ConversationsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> reorderConversations(List<String> ids) async {
    try {
      await _apiClient.put('/practice/conversations/reorder', data: {
        'conversation_ids': ids,
      });
    } catch (e) {
      rethrow;
    }
  }
}
