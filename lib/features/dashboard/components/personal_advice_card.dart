// AIによるパーソナルアドバイス
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

Widget PersonalAdviceCard(BuildContext context) {
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
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context)
                    .colorScheme
                    .primary
                    .withValues(red: 0, green: 0, blue: 0, alpha: 0.1),
                radius: 20,
                child: Icon(
                  Icons.tips_and_updates,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'AIによるパーソナルアドバイス',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '過去のテストから、前置詞の使い方に注意が必要です。特にin/on/atの使い分けが苦手なようです。',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    ),
  );
}
