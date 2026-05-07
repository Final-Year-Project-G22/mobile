import 'package:flutter/material.dart';

class TierBadge extends StatelessWidget {
  const TierBadge({required this.tierAccess, super.key});

  final String tierAccess;

  @override
  Widget build(BuildContext context) {
    if (tierAccess != 'pro') return const SizedBox.shrink();

    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'PRO',
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
