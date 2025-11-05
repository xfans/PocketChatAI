import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  final List<QuickActionItem> actions;

  const QuickActions({
    super.key,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: actions
            .map((action) => Container(
                  width: 80,
                  margin: const EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: action.backgroundColor ??
                              Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(
                            action.icon,
                            color: action.iconColor ??
                                Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: action.onPressed,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        action.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class QuickActionItem {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? iconColor;

  QuickActionItem({
    required this.icon,
    required this.title,
    required this.onPressed,
    this.backgroundColor,
    this.iconColor,
  });
}
