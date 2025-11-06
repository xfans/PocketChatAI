import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onMenuPressed,
    this.onBackPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: onBackPressed != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBackPressed,
            )
          : onMenuPressed != null
              ? IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: onMenuPressed,
                )
              : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
