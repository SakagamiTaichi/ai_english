import 'package:ai_english/core/components/footer.dart';
import 'package:ai_english/core/components/header.dart';
import 'package:ai_english/features/dashboard/components/learning_stats_card.dart';
import 'package:ai_english/features/dashboard/components/personal_advice_card.dart';
import 'package:ai_english/features/dashboard/components/streak_card.dart';
import 'package:ai_english/features/dashboard/components/test_completion_card.dart';
import 'package:ai_english/features/dashboard/providers/dashboard_provider.dart';
import 'package:ai_english/features/practice/pages/quiz_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardNotifierProvider);
    return Scaffold(
      appBar: header(context),
      body: Stack(
        children: [
          // メインコンテンツ（下のレイヤー）
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ウェルカムメッセージ
                  dashboardState.when(
                    data: (data) => Text(
                      data.message,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    loading: () => Text(
                      'こんにちは!',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    error: (error, stack) => Text(
                      'こんにちは!',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // AIによるパーソナルアドバイス
                  PersonalAdviceCard(context),
                  const SizedBox(height: 16),

                  // 総学習時間と連続学習日数
                  Row(
                    children: [
                      Expanded(child: LearningStatsCard(context)),
                      const SizedBox(width: 16),
                      Expanded(child: StreakCard(context, dashboardState)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // テスト完了状況
                  TestCompletionCard(context, dashboardState),
                  const SizedBox(height: 16),

                  // おすすめレッスン
                  Text(
                    '学習を始める',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),

                  // クイズ選択画面への遷移ボタン
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QuizSelectionPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.quiz),
                      label: const Text('クイズを始める'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: footer(context, false),
    );
  }
}
