import 'package:ai_english/core/http/iapi_client.dart';
import 'package:ai_english/features/practice/models/recall_test_request_model.dart';
import 'package:ai_english/features/practice/models/recall_test_response_model.dart';

abstract class IRecallTestResultRepository {
  Future<RecallTestSummaryResponseModel> fetchData(
      RecallTestRequestModel requestModel);
}

class RecallTestResultRepository implements IRecallTestResultRepository {
  final IApiClient _apiClient;

  RecallTestResultRepository(this._apiClient);

  @override
  Future<RecallTestSummaryResponseModel> fetchData(
      RecallTestRequestModel requestModel) async {
    try {
      final response = await _apiClient.post('/english/test_result',
          data: requestModel.toJson());
      // var data = response.data as List<dynamic>;
      return RecallTestSummaryResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
