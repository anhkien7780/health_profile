import 'package:flutter/material.dart';

class AppBadge extends StatelessWidget {
  const AppBadge({super.key, required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.colorScheme.error,
      ),
      child: Text(
        number.toString(),
        maxLines: 1,
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.onError,
        ),
      ),
    );
  }
}
