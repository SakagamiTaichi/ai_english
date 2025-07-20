import 'package:ai_english/core/http/iapi_client.dart';
import 'package:ai_english/features/practice/models/quiz_type_api_models.dart';

abstract class IQuizTypeRepository {
  Future<QuizTypesResponse> fetchQuizTypes();
  Future<Quiz> fetchQuiz({String? quizTypeId, required String questionType});
}

class QuizTypeRepository implements IQuizTypeRepository {
  final IApiClient _apiClient;

  QuizTypeRepository(this._apiClient);

  @override
  Future<QuizTypesResponse> fetchQuizTypes() async {
    try {
      final response = await _apiClient.get('/study/quiz_type');
      return QuizTypesResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Quiz> fetchQuiz({String? quizTypeId, required String questionType}) async {
    try {
      final queryParams = <String, dynamic>{
        'question_type': questionType,
      };
      
      if (quizTypeId != null) {
        queryParams['quiz_type_id'] = quizTypeId;
      }

      final response = await _apiClient.get('/study/quiz', queryParameters: queryParams);
      return Quiz.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}