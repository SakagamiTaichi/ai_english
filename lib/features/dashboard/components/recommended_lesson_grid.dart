// おすすめレッスン
import 'package:ai_english/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Widget RecommendedLessonsGrid(BuildContext context) {
  final lessons = [
    {
      'title': '前回のレッスン',
      'description': '買い物や道案内などの実用的な会話表現を学びます',
      'icon': Icons.shopping_cart,
      'progress': 0.3,
    },
    {
      'title': '最新のレッスン',
      'description': '会議やメールで使える基本的なビジネス表現',
      'icon': Icons.business_center,
      'progress': 0.0,
    },
    {
      'title': '前置詞マスター',
      'description': 'in/on/atなど前置詞の使い分けを徹底的に学習',
      'icon': Icons.school,
      'progress': 0.1,
    },
    {
      'title': '旅行英会話',
      'description': '海外旅行で役立つフレーズと表現',
      'icon': Icons.airplanemode_active,
      'progress': 0.0,
    },
  ];

  return GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 0.85,
    children:
        lessons.map((lesson) => _buildLessonCard(context, lesson)).toList(),
  );
}

Widget _buildLessonCard(BuildContext context, Map<String, dynamic> lesson) {
  final progress = lesson['progress'] as double;

  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppTheme.primary.withOpacity(0.2),
                  child: Icon(
                    lesson['icon'] as IconData,
                    color: AppTheme.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    lesson['title'] as String,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                lesson['description'] as String,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
            if (progress > 0)
              LinearPercentIndicator(
                lineHeight: 6.0,
                percent: progress,
                backgroundColor: Colors.grey.shade200,
                progressColor: AppTheme.primary,
                barRadius: const Radius.circular(3),
                padding: EdgeInsets.zero,
              )
            else
              Row(
                children: [
                  Icon(
                    Icons.play_circle_outline,
                    color: AppTheme.primary,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'New',
                    style: TextStyle(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    ),
  );
}
