import 'package:flutter/material.dart';

PreferredSizeWidget header(BuildContext context, String title) {
  return AppBar(
    toolbarHeight: Theme.of(context).appBarTheme.toolbarHeight,
    automaticallyImplyLeading: false,
    backgroundColor: Theme.of(context).colorScheme.inversePrimary.withAlpha(20),
  );
}
