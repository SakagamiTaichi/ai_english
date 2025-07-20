import 'dart:async';
import 'package:ai_english/features/practice/data/quiz_type_repository.dart';
import 'package:ai_english/features/practice/data/repository_providers.dart';
import 'package:ai_english/features/practice/models/quiz_type_api_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../generated/features/practice/providers/quiz_provider.g.dart';

@riverpod
class QuizProvider extends _$QuizProvider {
  late final IQuizTypeRepository _repository;
  
  @override
  FutureOr<Quiz?> build() async {
    _repository = ref.watch(quizTypeRepositoryProvider);
    return null;
  }

  Future<void> fetchQuiz({String? quizTypeId, required String questionType}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => 
      _repository.fetchQuiz(quizTypeId: quizTypeId, questionType: questionType)
    );
  }

  void clearQuiz() {
    state = const AsyncData(null);
  }
}