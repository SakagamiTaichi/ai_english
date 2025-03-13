import 'package:ai_english/core/http/api_client_provider.dart';
import 'package:ai_english/features/chat/data/recall_test_result_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recall_test_result_repository_provider.g.dart';

@riverpod
RecallTestResultRepository recallTestResultRepository(Ref ref) {
  return RecallTestResultRepository(ref.watch(apiClientProvider));
}
