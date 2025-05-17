import 'package:ai_english/core/http/iapi_client.dart';
import 'package:ai_english/features/practice/models/conversation_set.dart';

abstract class IConversationSetRepository {
  Future<String?> aiRegistration(String userPhrase);
}

class ConversationSetRepository implements IConversationSetRepository {
  final IApiClient _apiClient;

  ConversationSetRepository(this._apiClient);

  @override
  Future<String?> aiRegistration(String userPhrase) async {
    try {
      var response = await _apiClient
          .post('/practice/conversation/ai-registration', data: {
        'user_phrase': userPhrase,
      });
      return ConversationSetResponse.fromJson(response.data).id;
    } catch (e) {
      rethrow;
    }
  }
}
