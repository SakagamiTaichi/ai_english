import 'package:flutter/material.dart';

PreferredSizeWidget header(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: true,
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: const Text('Settings'),
  );
}
