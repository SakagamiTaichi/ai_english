import 'package:ai_english/core/http/iapi_client.dart';
import 'package:ai_english/features/chat/models/chat_history_detail.dart';

abstract class IChatHistoryDetailRepository {
  Future<List<ChatHistoryDetail>> fetchData(String id);
}

class ChatHistoryDetailRepository implements IChatHistoryDetailRepository {
  final IApiClient _apiClient;

  ChatHistoryDetailRepository(this._apiClient);

  @override
  Future<List<ChatHistoryDetail>> fetchData(String id) async {
    try {
      final response = await _apiClient.get('/english/message/$id');
      var data = response.data as List<dynamic>;
      return data.map((e) => ChatHistoryDetail.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
