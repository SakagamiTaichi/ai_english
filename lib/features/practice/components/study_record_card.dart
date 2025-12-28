import 'package:ai_english/core/utils/methods/date_formatter.dart';
import 'package:ai_english/features/practice/models/study_record_api_models.dart';
import 'package:ai_english/features/practice/pages/study_record_detail_page.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class StudyRecordCard extends StatelessWidget {
  final StudyRecord record;
  final QuizType quizType;

  const StudyRecordCard({
    super.key,
    required this.record,
    required this.quizType,
  });

  @override
  Widget build(BuildContext context) {
    final answeredDate = DateTime.parse(record.answeredAt);
    final formattedDate = DateFormatter.formatRelativeDateTime(answeredDate);
    
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StudyRecordDetailPage(
              userAnswerId: record.userAnswerId,
            ),
          ),
        );
      },
      borderRadius: SmoothBorderRadius(
        cornerRadius: 16,
        cornerSmoothing: 0.1,
      ),
      child: Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: SmoothBorderRadius(
          cornerRadius: 16,
          cornerSmoothing: 0.1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ヘッダー部分
            Row(
              children: [
                // クイズタイプ
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    quizType.name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                // 学習日
                Text(
                  formattedDate,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // 問題文
            Text(
              record.question,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 16),
            
            // 統計情報
            Row(
              children: [
                // スコア
                _InfoItem(
                  icon: Icons.grade,
                  label: 'スコア',
                  value: '${record.score}点',
                  color: _getScoreColor(record.score),
                ),
                
                const SizedBox(width: 24),
                
                // 回答時間
                _InfoItem(
                  icon: Icons.timer,
                  label: '回答時間',
                  value: '${record.answerTimeMinutes}分${record.answerTimeSeconds}秒',
                  color: Colors.blue,
                ),
                
                const Spacer(),
                
                // 復習完了
                if (record.isCompletedReview)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 16,
                          color: Colors.green[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '復習完了',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.green[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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
  
  Color _getScoreColor(int score) {
    if (score >= 90) return Colors.green;
    if (score >= 80) return Colors.orange;
    if (score >= 70) return Colors.amber;
    return Colors.red;
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: color,
        ),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}