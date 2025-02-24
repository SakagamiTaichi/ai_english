import 'package:ai_english/features/chat/data/chat_history_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:ai_english/features/chat/data/chat_history_repository.dart';
import 'package:ai_english/features/chat/models/chat_history.dart';
import 'package:ai_english/features/chat/providers/chat_history_provider.dart';

import 'chat_history_provider_test.mocks.dart';

@GenerateMocks([IChatHistoryRepository])
void main() {
  late MockIChatHistoryRepository mockRepository;
  late ProviderContainer container;
  late List<ChatHistory> testData;

  setUp(() {
    mockRepository = MockIChatHistoryRepository();
    container = ProviderContainer(
      overrides: [
        chatHistoryRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );

    testData = [
      ChatHistory(
          id: '1', title: 'English Conversation', created_at: DateTime.now()),
      ChatHistory(
          id: '2', title: 'Japanese Learning', created_at: DateTime.now()),
      ChatHistory(id: '3', title: 'TOEIC Practice', created_at: DateTime.now()),
    ];
  });

  tearDown(() {
    container.dispose();
  });

  group('AsyncChatHistory Tests', () {
    test('initial fetch should return conversations from repository', () async {
      // Arrange
      when(mockRepository.fetchConversations())
          .thenAnswer((_) async => testData);

      // Act
      final result = await container.read(asyncChatHistoryProvider.future);

      // Assert
      expect(result, equals(testData));
      verify(mockRepository.fetchConversations()).called(1);
    });

    test(
        'filterConversations with empty keyword should return all conversations',
        () async {
      // Arrange
      when(mockRepository.fetchConversations())
          .thenAnswer((_) async => testData);
      final provider = container.read(asyncChatHistoryProvider.notifier);
      await container.read(asyncChatHistoryProvider.future);

      // Act
      provider.filterConversations('');

      // Assert
      expect(
        container.read(asyncChatHistoryProvider).value,
        equals(testData),
      );
    });

    test('filterConversations should filter conversations by keyword',
        () async {
      // Arrange
      when(mockRepository.fetchConversations())
          .thenAnswer((_) async => testData);
      final provider = container.read(asyncChatHistoryProvider.notifier);
      await container.read(asyncChatHistoryProvider.future);

      // Act
      provider.filterConversations('english');

      // Assert
      expect(
        container.read(asyncChatHistoryProvider).value,
        equals([testData[0]]),
      );
    });

    test('filterConversations should be case insensitive', () async {
      // Arrange
      when(mockRepository.fetchConversations())
          .thenAnswer((_) async => testData);
      final provider = container.read(asyncChatHistoryProvider.notifier);
      await container.read(asyncChatHistoryProvider.future);

      // Act
      provider.filterConversations('ENGLISH');

      // Assert
      expect(
        container.read(asyncChatHistoryProvider).value,
        equals([testData[0]]),
      );
    });

    test('filterConversations should handle null _originalChatHistories',
        () async {
      // Arrange
      final provider = container.read(asyncChatHistoryProvider.notifier);

      // Act & Assert
      expect(
        () => provider.filterConversations('test'),
        returnsNormally,
      );
    });

    test('filterConversations should handle no matches', () async {
      // Arrange
      when(mockRepository.fetchConversations())
          .thenAnswer((_) async => testData);
      final provider = container.read(asyncChatHistoryProvider.notifier);
      await container.read(asyncChatHistoryProvider.future);

      // Act
      provider.filterConversations('nonexistent');

      // Assert
      expect(
        container.read(asyncChatHistoryProvider).value,
        isEmpty,
      );
    });
  });
}
