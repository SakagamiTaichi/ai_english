import 'package:ai_english/core/http/iapi_client.dart';
import 'package:ai_english/features/practice/models/conversation.dart';

abstract class IConversationRepository {
  Future<ConversationResponse> fetchData(String id);
}

class ConversationRepository implements IConversationRepository {
  final IApiClient _apiClient;

  ConversationRepository(this._apiClient);

  @override
  Future<ConversationResponse> fetchData(String id) async {
    try {
      final response = await _apiClient.get('/practice/conversation/$id');

      return ConversationResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
