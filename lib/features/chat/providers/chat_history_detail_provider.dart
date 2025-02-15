import 'package:ai_english/core/http/api_client.dart';
import 'package:ai_english/features/chat/models/chat_history_detail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_history_detail_provider.g.dart';

@riverpod
class AsyncChatHistoryDetail extends _$AsyncChatHistoryDetail {
  late final ApiClient _apiClient;

  @override
  FutureOr<List<ChatHistoryDetail>> build(String id) async {
    _apiClient = ApiClient();
    return await _fetchConversations(id);
  }

  Future<List<ChatHistoryDetail>> _fetchConversations(String id) async {
    try {
      final response = await _apiClient.get('/english/message/$id');
      var data = response.data as List<dynamic>;
      return data.map((e) => ChatHistoryDetail.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
