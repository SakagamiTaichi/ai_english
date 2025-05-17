import 'package:ai_english/features/practice/data/recall_test_result_repository.dart';
import 'package:ai_english/features/practice/data/repository_providers.dart';
import 'package:ai_english/features/practice/models/recall_test_request_model.dart';
import 'package:ai_english/features/practice/models/recall_test_response_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../generated/features/practice/providers/recall_test_result_provider.g.dart';

@riverpod
class RecallTestResultProvider extends _$RecallTestResultProvider {
  late final IRecallTestResultRepository _repository;
  @override
  FutureOr<RecallTestSummaryResponseModel> build(
      RecallTestRequestModel requestModel) async {
    _repository = ref.watch(recallTestResultRepositoryProvider);
    return await _fetchData();
  }

  Future<RecallTestSummaryResponseModel> _fetchData() async {
    final data = await _repository.fetchData(requestModel);
    return data;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchData());
  }
}
