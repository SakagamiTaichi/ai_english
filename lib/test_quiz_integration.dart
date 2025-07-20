// Temporary test file to validate quiz answer integration
import 'package:ai_english/features/practice/models/quiz_type_api_models.dart';

void main() {
  // Test QuizAnswerRequest
  final request = QuizAnswerRequest(
    userAnswer: "Sorry to trouble you — I'm studying right now and it's a bit hard to concentrate. Would you mind speaking a little more quietly?",
    quizId: "a073576e-0e15-f9be-9376-aa224ba4c6f9",
  );
  
  print('Request: ${request.toJson()}');
  
  // Test QuizAnswerResponse
  final responseJson = {
    "score": 95,
    "user_answer": "Sorry to trouble you — I'm studying right now and it's a bit hard to concentrate. Would you mind speaking a little more quietly?",
    "ai_model_answer": "Excuse me, I'm sorry to bother you, but I'm trying to study and it's hard to concentrate with the noise. Would you mind speaking a little more quietly, please?",
    "ai_feedback": "とても丁寧で自然な表現です。\"Sorry to trouble you\" の使い方や、\"Would you mind speaking a little more quietly?\" の丁寧な依頼表現が適切です。改善点としては、\"It's a bit hard to concentrate\" の部分をもう少し明確にすると、相手に状況が伝わりやすくなりますが、現在の表現でも十分伝わります。"
  };
  
  final response = QuizAnswerResponse.fromJson(responseJson);
  print('Response score: ${response.score}');
  print('Integration test passed!');
}