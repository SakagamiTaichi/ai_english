import 'package:ai_english/features/practice/data/conversation_repository.dart';
import 'package:ai_english/features/practice/data/repository_providers.dart';
import 'package:ai_english/features/practice/models/conversation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../generated/features/practice/providers/conversation_provider.g.dart';

@riverpod
class ConversationNotifier extends _$ConversationNotifier {
  late final IConversationRepository _repository;
  @override
  FutureOr<ConversationResponse> build(String id) async {
    _repository = ref.watch(conversationRepositoryProvider);
    return await _fetchData(id);
  }

  Future<ConversationResponse> _fetchData(String id) async {
    final data = await _repository.fetchData(id);
    return data;
  }
}
