import 'package:ai_english/core/http/iapi_client.dart';
import 'package:ai_english/features/practice/models/conversations.dart';

abstract class IConversationsRepository {
  Future<ConversationsResponse> fetchConversations();
}

class ConversationsRepository implements IConversationsRepository {
  final IApiClient _apiClient;

  ConversationsRepository(this._apiClient);

  @override
  Future<ConversationsResponse> fetchConversations() async {
    try {
      final response = await _apiClient.get('/practice/conversations');
      var data = response.data as List<dynamic>;
      return ConversationsResponse.fromJson({
        'conversation':
            data.map((e) => ConversationResponse.fromJson(e)).toList()
      });
    } catch (e) {
      rethrow;
    }
  }
}
