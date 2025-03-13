import 'package:ai_english/features/practice/data/conversation_repository.dart';
import 'package:ai_english/features/practice/data/conversation_repository_provider.dart';
import 'package:ai_english/features/practice/models/chat_history_detail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../generated/features/practice/providers/chat_history_detail_provider.g.dart';

@riverpod
class ConversationNotifier extends _$ConversationNotifier {
  late final IConversationRepository _repository;
  @override
  FutureOr<List<Conversation>> build(String id) async {
    _repository = ref.watch(conversationRepositoryProvider);
    return await _fetchData(id);
  }

  Future<List<Conversation>> _fetchData(String id) async {
    final data = await _repository.fetchData(id);
    return data;
  }
}
