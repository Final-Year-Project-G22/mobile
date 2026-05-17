import 'package:flutter/material.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';

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
    final borderColor = highlight
        ? colorScheme.primary
        : colorScheme.outlineVariant;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: highlight ? 2 : 1),
        borderRadius: BorderRadius.circular(16),
        color: theme.colorScheme.surface,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (highlight)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                AppLocalizations.of(context).mostPopular,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: 12),
          Text(title, style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(price, style: theme.textTheme.headlineMedium),
              const SizedBox(width: 4),
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
          const SizedBox(height: 16),
          ...features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(
                    isPro ? Icons.check_circle : Icons.check,
                    size: 18,
                    color: isPro
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(f, style: theme.textTheme.bodyMedium)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
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
                borderRadius: BorderRadius.circular(12),
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
