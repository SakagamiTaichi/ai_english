import 'package:flutter/material.dart';

PreferredSizeWidget header(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: const Text('Settings'),
  );
}
