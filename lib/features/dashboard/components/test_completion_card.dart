// テスト完了状況
import 'package:ai_english/features/dashboard/models/dashboard_api_models.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Widget TestCompletionCard(BuildContext context, AsyncValue<HomeResponseModel> dashboardState) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
        borderRadius: SmoothBorderRadius(
      cornerRadius: 20,
      cornerSmoothing: 0.1,
    )),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'テスト完了状況',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          dashboardState.when(
            data: (data) {
              final completionRate = data.allQuizCount > 0 
                  ? data.completeReviewCount / data.allQuizCount 
                  : 0.0;
              return LinearPercentIndicator(
                lineHeight: 20.0,
                percent: completionRate,
                backgroundColor: Colors.grey.shade200,
                progressColor: Theme.of(context).primaryColor,
                barRadius: const Radius.circular(10),
                animation: true,
                animationDuration: 1500,
                center: Text(
                  '${(completionRate * 100).toInt()}% 完了',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
            loading: () => LinearPercentIndicator(
              lineHeight: 20.0,
              percent: 0.6,
              backgroundColor: Colors.grey.shade200,
              progressColor: Theme.of(context).primaryColor,
              barRadius: const Radius.circular(10),
              animation: true,
              animationDuration: 1500,
              center: const Text(
                '60% 完了',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            error: (error, stack) => LinearPercentIndicator(
              lineHeight: 20.0,
              percent: 0.0,
              backgroundColor: Colors.grey.shade200,
              progressColor: Theme.of(context).primaryColor,
              barRadius: const Radius.circular(10),
              animation: true,
              animationDuration: 1500,
              center: const Text(
                '0% 完了',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          dashboardState.when(
            data: (data) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTestProgress(
                  context,
                  icon: Icons.pending_actions,
                  title: '復習待ち',
                  progress: '${data.pendingReviewCount}',
                ),
                _buildTestProgress(
                  context,
                  icon: Icons.quiz,
                  title: '総クイズ数',
                  progress: '${data.allQuizCount}',
                ),
                _buildTestProgress(
                  context,
                  icon: Icons.grade,
                  title: '平均スコア',
                  progress: '${data.averageScore.toInt()}%',
                ),
              ],
            ),
            loading: () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTestProgress(
                  context,
                  icon: Icons.chat,
                  title: '会話',
                  progress: '6/10',
                ),
                _buildTestProgress(
                  context,
                  icon: Icons.edit,
                  title: '文法',
                  progress: '4/5',
                ),
                _buildTestProgress(
                  context,
                  icon: Icons.volume_up,
                  title: 'リスニング',
                  progress: '3/7',
                ),
              ],
            ),
            error: (error, stack) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTestProgress(
                  context,
                  icon: Icons.error,
                  title: 'エラー',
                  progress: '-',
                ),
                _buildTestProgress(
                  context,
                  icon: Icons.error,
                  title: 'エラー',
                  progress: '-',
                ),
                _buildTestProgress(
                  context,
                  icon: Icons.error,
                  title: 'エラー',
                  progress: '-',
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildTestProgress(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String progress,
}) {
  return Column(
    children: [
      Icon(icon, color: Theme.of(context).primaryColor),
      const SizedBox(height: 4),
      Text(title, style: Theme.of(context).textTheme.bodySmall),
      Text(
        progress,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    ],
  );
}
