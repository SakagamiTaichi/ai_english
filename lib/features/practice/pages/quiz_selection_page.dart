import 'package:ai_english/core/components/error_feedback.dart';
import 'package:ai_english/core/components/footer.dart';
import 'package:ai_english/core/components/header.dart';
import 'package:ai_english/core/constans/master.dart';
import 'package:ai_english/features/practice/models/quiz_type_api_models.dart';
import 'package:ai_english/features/practice/pages/quiz_display_page.dart';
import 'package:ai_english/features/practice/providers/quiz_types_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

enum StudyMode { newAndReview, newOnly, reviewOnly }

class QuizSelectionPage extends ConsumerStatefulWidget {
  const QuizSelectionPage({super.key});

  @override
  ConsumerState<QuizSelectionPage> createState() => _QuizSelectionPageState();
}

class _QuizSelectionPageState extends ConsumerState<QuizSelectionPage> {
  StudyMode _selectedMode = StudyMode.newAndReview;

  @override
  Widget build(BuildContext context) {
    final quizTypesState = ref.watch(quizTypesProviderProvider);

    return Scaffold(
      appBar: header(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'クイズを選択',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),

              // Study mode selection
              _buildStudyModeSelector(),
              const SizedBox(height: 24),

              // Quiz type cards
              quizTypesState.when(
                loading: () => _buildLoadingQuizCards(),
                error: (error, _) => ErrorFeedback(
                  error: error,
                  onRetry: () => ref.refresh(quizTypesProviderProvider),
                ),
                data: (quizTypes) => _buildQuizTypeCards(quizTypes),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: footer(context, true),
    );
  }

  Widget _buildStudyModeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildStudyModeChip(
              StudyMode.newAndReview,
              'すべて',
            ),
            _buildStudyModeChip(
              StudyMode.newOnly,
              '新規のみ',
            ),
            _buildStudyModeChip(
              StudyMode.reviewOnly,
              '復習のみ',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStudyModeChip(
    StudyMode mode,
    String title,
  ) {
    final isSelected = _selectedMode == mode;

    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 4),
          Text(title),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedMode = mode;
          });
        }
      },
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
      checkmarkColor: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildLoadingQuizCards() {
    return Skeletonizer(
      enabled: true,
      enableSwitchAnimation: true,
      child: Column(
        children: [
          _buildQuizTypeCard(
            const QuizType(
              id: 'loading',
              name: 'ランダム問題',
              description: 'すべてのクイズの種類からランダムに出題されます',
            ),
            Icons.casino,
            true,
          ),
          const SizedBox(height: 12),
          ...List.generate(
            2,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildQuizTypeCard(
                const QuizType(
                  id: 'loading',
                  name: 'クイズタイプ名',
                  description: 'クイズの説明がここに表示されます',
                ),
                Icons.quiz,
                false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizTypeCards(List<QuizType> quizTypes) {
    return Column(
      children: [
        // Random quiz option first
        _buildQuizTypeCard(
          const QuizType(
            id: 'random',
            name: 'ランダム問題',
            description: 'すべてのクイズの種類からランダムに出題されます',
          ),
          Icons.casino,
          true,
        ),
        const SizedBox(height: 12),

        // API quiz types
        ...quizTypes.map((quizType) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildQuizTypeCard(
                  quizType, _getIconForQuizType(quizType.id), false),
            )),
      ],
    );
  }

  IconData _getIconForQuizType(String quizTypeId) {
    switch (quizTypeId.toLowerCase()) {
      case QuizTypeMaster.situation:
        return Icons.book;
      case QuizTypeMaster.translation:
        return Icons.translate;
      case QuizTypeMaster.conversation:
        return Icons.chat;
      case QuizTypeMaster.wordExplain:
        return Icons.description;
      case QuizTypeMaster.phraseOrWordUse:
        return Icons.format_quote;
      default:
        return Icons.quiz;
    }
  }

  Widget _buildQuizTypeCard(QuizType quizType, IconData icon, bool isRandom) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _startQuiz(quizType, isRandom),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quizType.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      quizType.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.shade400,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startQuiz(QuizType quizType, bool isRandom) {
    String questionType;
    switch (_selectedMode) {
      case StudyMode.newAndReview:
        questionType = 'mixed';
        break;
      case StudyMode.newOnly:
        questionType = 'new';
        break;
      case StudyMode.reviewOnly:
        questionType = 'review';
        break;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QuizDisplayPage(
          quizTypeId: isRandom ? null : quizType.id,
          questionType: questionType,
        ),
      ),
    );
  }
}
