import 'package:ai_english/core/components/footer.dart';
import 'package:ai_english/core/components/header.dart';
import 'package:ai_english/features/dashboard/components/learning_stats_card.dart';
import 'package:ai_english/features/dashboard/components/personal_advice_card.dart';
import 'package:ai_english/features/dashboard/components/recommended_lesson_grid.dart';
import 'package:ai_english/features/dashboard/components/streak_card.dart';
import 'package:ai_english/features/dashboard/components/test_completion_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    'こんにちは!',
                    style: Theme.of(context).textTheme.headlineMedium,
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
                      Expanded(child: StreakCard(context)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // テスト完了状況
                  TestCompletionCard(context),
                  const SizedBox(height: 16),

                  // おすすめレッスン
                  Text(
                    'おすすめレッスン',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  RecommendedLessonsGrid(context),
                ],
              ),
            ),
          ),

          // 花吹雪アニメーション（上のレイヤー）
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: Container(
                  child: Lottie.asset(
                    height: MediaQuery.of(context).size.height * 1.2,
                    width: MediaQuery.of(context).size.width * 1.2,
                    'assets/lottie/confetti.json',
                    fit: BoxFit.fill,
                    animate: true,
                    repeat: false,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: footer(context, false),
    );
  }
}
