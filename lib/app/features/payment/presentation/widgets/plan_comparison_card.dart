import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';

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
    final borderColor = highlight ? AppColors.accent : theme.colorScheme.outline.withAlpha(128);

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
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Most Popular',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.white,
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
                    color: AppColors.slate500,
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
                    color: isPro ? AppColors.accent : AppColors.slate400,
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
                backgroundColor: highlight ? AppColors.accent : AppColors.primary,
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: onSubscribe,
              child: const Text('Subscribe'),
            )
          else if (currentPlan)
            Container(
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.slate100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Current Plan',
                style: theme.textTheme.labelLarge?.copyWith(color: AppColors.slate500),
              ),
            ),
        ],
      ),
    );
  }
}
