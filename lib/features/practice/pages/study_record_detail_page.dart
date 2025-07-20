import 'package:ai_english/features/practice/models/study_record_api_models.dart';
import 'package:ai_english/features/practice/providers/study_record_detail_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class StudyRecordDetailPage extends ConsumerWidget {
  final String userAnswerId;

  const StudyRecordDetailPage({
    super.key,
    required this.userAnswerId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studyRecordDetailAsync = ref.watch(studyRecordDetailProvider(userAnswerId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('学習詳細'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: studyRecordDetailAsync.when(
        data: (data) => _buildContent(context, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('エラーが発生しました: $error'),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, StudyRecordDetailResponse data) {
    final quiz = data.quiz;
    final answers = data.userAnswers;

    // 統計データを計算
    final maxScore = answers.isNotEmpty ? answers.map((a) => a.aiEvaluationScore).reduce((a, b) => a > b ? a : b) : 0;
    final challengeCount = answers.length;
    final firstChallengeDate = answers.isNotEmpty ? answers.last.answeredAt : '';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 問題情報セクション
          _buildQuizInfoCard(context, quiz, maxScore, challengeCount, firstChallengeDate),
          const SizedBox(height: 16),

          // スコア推移グラフ
          _buildScoreChart(context, answers),
          const SizedBox(height: 16),

          // 挑戦結果一覧
          _buildAnswersList(context, answers),
        ],
      ),
    );
  }

  Widget _buildQuizInfoCard(BuildContext context, QuizDetail quiz, int maxScore, int challengeCount, String firstChallengeDate) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '問題情報',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              quiz.content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem('最高得点', '$maxScore点'),
                ),
                Expanded(
                  child: _buildInfoItem('挑戦回数', '$challengeCount回'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem('初回挑戦日', _formatDate(firstChallengeDate)),
                ),
                Expanded(
                  child: _buildInfoItem('種類', quiz.type),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildInfoItem('難易度', quiz.difficulty),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildScoreChart(BuildContext context, List<UserAnswer> answers) {
    if (answers.isEmpty) {
      return const SizedBox.shrink();
    }

    // 時系列順にソート（古い順）
    final sortedAnswers = List<UserAnswer>.from(answers)
      ..sort((a, b) => DateTime.parse(a.answeredAt).compareTo(DateTime.parse(b.answeredAt)));

    final spots = sortedAnswers.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.aiEvaluationScore.toDouble());
    }).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '学習進捗（スコア推移）',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}',
                            style: const TextStyle(fontSize: 12),
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < sortedAnswers.length) {
                            return Text(
                              '${index + 1}回目',
                              style: const TextStyle(fontSize: 10),
                            );
                          }
                          return const Text('');
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: true),
                  minX: 0,
                  maxX: (spots.length - 1).toDouble(),
                  minY: 0,
                  maxY: 100,
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: Theme.of(context).primaryColor,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswersList(BuildContext context, List<UserAnswer> answers) {
    // 時系列順にソート（新しい順）
    final sortedAnswers = List<UserAnswer>.from(answers)
      ..sort((a, b) => DateTime.parse(b.answeredAt).compareTo(DateTime.parse(a.answeredAt)));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '挑戦結果一覧',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sortedAnswers.length,
          itemBuilder: (context, index) {
            final answer = sortedAnswers[index];
            final previousAnswer = index < sortedAnswers.length - 1 ? sortedAnswers[index + 1] : null;
            final scoreDiff = previousAnswer != null 
                ? answer.aiEvaluationScore - previousAnswer.aiEvaluationScore 
                : 0;

            return _buildAnswerCard(context, answer, scoreDiff, index + 1);
          },
        ),
      ],
    );
  }

  Widget _buildAnswerCard(BuildContext context, UserAnswer answer, int scoreDiff, int attemptNumber) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ヘッダー部分
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '第${attemptNumber}回目の挑戦',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _formatDateTime(answer.answeredAt),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // スコア情報
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getScoreColor(answer.aiEvaluationScore),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${answer.aiEvaluationScore}点',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (scoreDiff != 0) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: scoreDiff > 0 ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${scoreDiff > 0 ? '+' : ''}$scoreDiff点',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),

            // ユーザー回答
            _buildAnswerSection('あなたの回答', answer.userAnswer, Colors.blue.shade50),
            const SizedBox(height: 8),

            // AIフィードバック
            _buildAnswerSection('AIフィードバック', answer.aiFeedback, Colors.green.shade50),
            const SizedBox(height: 8),

            // AI模範解答
            _buildAnswerSection('AI模範解答', answer.aiModelAnswer, Colors.orange.shade50),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerSection(String title, String content, Color backgroundColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.orange;
    return Colors.red;
  }

  String _formatDate(String dateString) {
    if (dateString.isEmpty) return '-';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('yyyy/MM/dd').format(date);
    } catch (e) {
      return '-';
    }
  }

  String _formatDateTime(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('yyyy/MM/dd HH:mm').format(date);
    } catch (e) {
      return dateString;
    }
  }
}