import 'package:ai_english/core/http/api_client.dart';
import 'package:ai_english/features/chat/data/chat_history_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_history_repository_provider.g.dart';

@riverpod
IChatHistoryRepository chatHistoryRepository(Ref ref) {
  return ChatHistoryRepository(ApiClient());
}
