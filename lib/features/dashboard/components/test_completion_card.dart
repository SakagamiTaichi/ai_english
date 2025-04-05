// テスト完了状況
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Widget TestCompletionCard(BuildContext context) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
          LinearPercentIndicator(
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
          const SizedBox(height: 12),
          Row(
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
