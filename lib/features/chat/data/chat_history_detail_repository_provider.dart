import 'package:ai_english/core/http/api_client_provider.dart';
import 'package:ai_english/features/chat/data/chat_history_detail_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_history_detail_repository_provider.g.dart';

@riverpod
IChatHistoryDetailRepository chatHistoryDetailRepository(Ref ref) {
  return ChatHistoryDetailRepository(ref.watch(apiClientProvider));
}
