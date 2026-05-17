import 'package:flutter/material.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../constants/app_spacing.dart';

class TierBadge extends StatelessWidget {
  const TierBadge({required this.tierAccess, super.key});

  final String tierAccess;

  @override
  Widget build(BuildContext context) {
    if (tierAccess != 'pro') return const SizedBox.shrink();

    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiaryContainer,
        borderRadius: AppSpacing.borderRadiusXs,
      ),
      child: Text(
        AppLocalizations.of(context).pro,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onTertiaryContainer,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
