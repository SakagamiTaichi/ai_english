import 'package:ai_english/features/chat/data/recall_test_result_repository.dart';
import 'package:ai_english/features/chat/data/recall_test_result_repository_provider.dart';
import 'package:ai_english/features/chat/models/recall_test_request_model.dart';
import 'package:ai_english/features/chat/models/recall_test_response_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recall_test_result_provider.g.dart';

@riverpod
class RecallTestResultProvider extends _$RecallTestResultProvider {
  late final IRecallTestResultRepository _repository;
  @override
  FutureOr<RecallTestSummaryResponseModel> build(
      RecallTestRequestModel requestModel) async {
    _repository = ref.watch(recallTestResultRepositoryProvider);
    return await _fetchData(requestModel);
  }

  Future<RecallTestSummaryResponseModel> _fetchData(
      RecallTestRequestModel requestModel) async {
    final data = await _repository.fetchData(requestModel);
    return data;
  }
}
