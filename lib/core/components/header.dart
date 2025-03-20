import 'package:flutter/material.dart';

PreferredSizeWidget header(BuildContext context,
    {bool isDisplayBackButton = false}) {
  return AppBar(
    toolbarHeight: Theme.of(context).appBarTheme.toolbarHeight,
    automaticallyImplyLeading: isDisplayBackButton,
    foregroundColor: Theme.of(context).colorScheme.primary,
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  );
}
