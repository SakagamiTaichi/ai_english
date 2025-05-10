import 'package:ai_english/features/practice/data/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../../../generated/features/practice/providers/conversation_set_provider.g.dart';

// AI会話生成の状態
enum AiRegistrationStatus {
  initial,
  loading,
  success,
  error,
}

// AI会話生成の状態を管理するプロバイダー
@riverpod
class AiRegistrationNotifier extends _$AiRegistrationNotifier {
  @override
  AiRegistrationStatus build() {
    return AiRegistrationStatus.initial;
  }

  // AI会話を生成する
  Future<String?> registerAiConversation(String userPhrase) async {
    if (userPhrase.trim().isEmpty) return null;

    try {
      state = AiRegistrationStatus.loading;

      final repository = ref.read(conversationSetRepositoryProvider);
      state = AiRegistrationStatus.success;
      return await repository.aiRegistration(userPhrase);
    } catch (e) {
      state = AiRegistrationStatus.error;
      rethrow;
    }
  }

  // 状態をリセットする
  void reset() {
    state = AiRegistrationStatus.initial;
  }
}
