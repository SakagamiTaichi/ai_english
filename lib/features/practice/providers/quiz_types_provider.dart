import 'package:ai_english/features/practice/data/quiz_type_repository.dart';
import 'package:ai_english/features/practice/data/repository_providers.dart';
import 'package:ai_english/features/practice/models/quiz_type_api_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../generated/features/practice/providers/quiz_types_provider.g.dart';

@riverpod
class QuizTypesProvider extends _$QuizTypesProvider {
  late final IQuizTypeRepository _repository;
  
  @override
  FutureOr<List<QuizType>> build() async {
    _repository = ref.watch(quizTypeRepositoryProvider);
    return await _fetchData();
  }

  Future<List<QuizType>> _fetchData() async {
    final response = await _repository.fetchQuizTypes();
    return response.quizTypes;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchData());
  }
}