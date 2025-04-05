import 'package:flutter/material.dart';

Widget fabOptionButton({
  required BuildContext context,
  required bool isDialOpen,
  required Function() toggleFabOptions,
}) {
  return FloatingActionButton(
    onPressed: toggleFabOptions,
    backgroundColor: isDialOpen
        ? Colors.grey.shade700
        : Theme.of(context).colorScheme.primary,
    foregroundColor: Colors.white,
    elevation: 4,
    shape: const CircleBorder(),
    child: AnimatedRotation(
      turns: isDialOpen ? 0.125 : 0.0, // 45度回転
      duration: const Duration(milliseconds: 300),
      child: Icon(isDialOpen ? Icons.add : Icons.add),
    ),
  );
}
