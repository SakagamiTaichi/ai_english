import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget LearningStatsCard(BuildContext context) {
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
            '今週の学習時間',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          CircularPercentIndicator(
            radius: 50,
            lineWidth: 10.0,
            percent: 0.75,
            center: const Text(
              '45h',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            progressColor: Theme.of(context).primaryColor,
            backgroundColor: Theme.of(context)
                .colorScheme
                .primary
                .withValues(red: 0, green: 0, blue: 0, alpha: 0.1),
            circularStrokeCap: CircularStrokeCap.round,
            animation: true,
            animationDuration: 1500,
          ),
          const SizedBox(height: 12),
          Text(
            '累積: 60時間',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    ),
  );
}
