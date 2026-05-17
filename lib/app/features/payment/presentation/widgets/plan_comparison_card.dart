import 'package:flutter/material.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../constants/app_spacing.dart';

class PlanComparisonCard extends StatelessWidget {
  const PlanComparisonCard({
    required this.title,
    required this.price,
    required this.period,
    this.features = const [],
    this.isPro = false,
    this.highlight = false,
    this.onSubscribe,
    this.currentPlan = false,
    super.key,
  });

  final String title;
  final String price;
  final String period;
  final List<String> features;
  final bool isPro;
  final bool highlight;
  final VoidCallback? onSubscribe;
  final bool currentPlan;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final accentColor = isPro ? colorScheme.tertiary : colorScheme.primary;
    final accentOnColor = isPro
        ? colorScheme.onTertiary
        : colorScheme.onPrimary;
    final borderColor = highlight ? accentColor : colorScheme.outlineVariant;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: highlight ? 2 : 1),
        borderRadius: AppSpacing.borderRadiusMd,
        color: theme.colorScheme.surface,
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (highlight)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xxs,
              ),
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: AppSpacing.borderRadiusSm,
              ),
              child: Text(
                AppLocalizations.of(context).mostPopular,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: accentOnColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: AppSpacing.sm),
          Text(title, style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.xs),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price, style: theme.textTheme.headlineMedium),
              const SizedBox(width: AppSpacing.xxs),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  period,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ...features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Row(
                children: [
                  Icon(
                    isPro ? Icons.check_circle : Icons.check,
                    size: 18,
                    color: isPro
                        ? colorScheme.tertiary
                        : colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(child: Text(f, style: theme.textTheme.bodyMedium)),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          if (onSubscribe != null)
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: onSubscribe,
              child: Text(AppLocalizations.of(context).subscribe),
            )
          else if (currentPlan)
            Container(
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: AppSpacing.borderRadiusMd,
              ),
              child: Text(
                AppLocalizations.of(context).currentPlan,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
