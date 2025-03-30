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
      var data = response.data as List<dynamic>;

      return ConversationResponse.fromJson({
        'conversation': data.map((e) => MessageResponse.fromJson(e)).toList()
      });
    } catch (e) {
      rethrow;
    }
  }
}
