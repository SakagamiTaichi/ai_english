import 'package:flutter/material.dart';

Widget fabOption({
  required BuildContext context,
  required String label,
  required IconData icon,
  required VoidCallback onTap,
}) {
  final theme = Theme.of(context);

  return GestureDetector(
    onTap: onTap,
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            label,
            style: theme.textTheme.titleSmall?.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: CircleAvatar(
            backgroundColor: theme.colorScheme.primary,
            radius: 24,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
