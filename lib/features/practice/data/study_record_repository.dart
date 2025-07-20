import 'package:ai_english/core/http/api_client.dart';
import 'package:ai_english/features/practice/models/study_record_api_models.dart';

class StudyRecordRepository {
  final ApiClient _apiClient;

  StudyRecordRepository(this._apiClient);

  Future<StudyRecordsResponse> getStudyRecords() async {
    try {
      final response = await _apiClient.get('/study/records');
      return StudyRecordsResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<StudyRecordDetailResponse> getStudyRecordDetail(String userAnswerId) async {
    try {
      final response = await _apiClient.get('/study/record/$userAnswerId');
      return StudyRecordDetailResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}