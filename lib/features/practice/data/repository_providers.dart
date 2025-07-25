// lib/features/practice/data/repository_providers.dart
import 'package:ai_english/core/http/api_client_provider.dart';
import 'package:ai_english/features/practice/data/conversation_repository.dart';
import 'package:ai_english/features/practice/data/conversation_set_repository.dart';
import 'package:ai_english/features/practice/data/conversations_repository.dart';
import 'package:ai_english/features/practice/data/quiz_type_repository.dart';
import 'package:ai_english/features/practice/data/recall_test_result_repository.dart';
import 'package:ai_english/features/practice/data/study_record_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../generated/features/practice/data/repository_providers.g.dart';

// 単一の会話用リポジトリプロバイダー
@riverpod
IConversationRepository conversationRepository(Ref ref) {
  return ConversationRepository(ref.watch(apiClientProvider));
}

// 会話一覧用リポジトリプロバイダー
@riverpod
IConversationsRepository conversationsRepository(Ref ref) {
  return ConversationsRepository(ref.watch(apiClientProvider));
}

// リコールテスト結果用リポジトリプロバイダー
@riverpod
IRecallTestResultRepository recallTestResultRepository(Ref ref) {
  return RecallTestResultRepository(ref.watch(apiClientProvider));
}

// AI生成会話登録用リポジトリプロバイダー
@riverpod
IConversationSetRepository conversationSetRepository(Ref ref) {
  return ConversationSetRepository(ref.watch(apiClientProvider));
}

// クイズタイプ用リポジトリプロバイダー
@riverpod
IQuizTypeRepository quizTypeRepository(Ref ref) {
  return QuizTypeRepository(ref.watch(apiClientProvider));
}

// 学習履歴用リポジトリプロバイダー
@riverpod
StudyRecordRepository studyRecordRepository(Ref ref) {
  return StudyRecordRepository(ref.watch(apiClientProvider));
}
