import 'package:ai_english/features/chat/data/chat_history_detail_repository.dart';
import 'package:ai_english/features/chat/data/chat_history_detail_repository_provider.dart';
import 'package:ai_english/features/chat/models/chat_history_detail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../generated/features/chat/providers/chat_history_detail_provider.g.dart';

@riverpod
class AsyncChatHistoryDetail extends _$AsyncChatHistoryDetail {
  late final IChatHistoryDetailRepository _repository;
  @override
  FutureOr<List<ChatHistoryDetail>> build(String id) async {
    _repository = ref.watch(chatHistoryDetailRepositoryProvider);
    return await _fetchData(id);
  }

  Future<List<ChatHistoryDetail>> _fetchData(String id) async {
    final data = await _repository.fetchData(id);
    return data;
  }
}
