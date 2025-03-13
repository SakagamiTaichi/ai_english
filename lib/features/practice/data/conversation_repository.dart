import 'package:ai_english/core/http/iapi_client.dart';
import 'package:ai_english/features/practice/models/chat_history_detail.dart';

abstract class IConversationRepository {
  Future<List<Conversation>> fetchData(String id);
}

class ConversationRepository implements IConversationRepository {
  final IApiClient _apiClient;

  ConversationRepository(this._apiClient);

  @override
  Future<List<Conversation>> fetchData(String id) async {
    try {
      final response = await _apiClient.get('/english/message/$id');
      var data = response.data as List<dynamic>;
      return data.map((e) => Conversation.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
