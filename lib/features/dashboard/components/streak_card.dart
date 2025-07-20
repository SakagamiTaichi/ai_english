// 連続学習日数
import 'package:ai_english/features/dashboard/models/dashboard_api_models.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget StreakCard(BuildContext context, AsyncValue<HomeResponseModel> dashboardState) {
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '連続学習日数',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.local_fire_department,
                color: Colors.deepOrange,
                size: 36,
              ),
              const SizedBox(width: 8),
              dashboardState.when(
                data: (data) => Text(
                  '${data.continuousLearningDays}日',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                loading: () => Text(
                  '7日',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                error: (error, stack) => Text(
                  '0日',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '最高記録: 14日',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    ),
  );
}
