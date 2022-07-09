import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    Key? key,
    required this.title,
    this.actions,
  }) : super(key: key);

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) => AppBar(
        title: Text(title),
        actions: actions,
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
