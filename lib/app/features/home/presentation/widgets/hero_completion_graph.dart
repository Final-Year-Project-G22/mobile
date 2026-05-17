import 'package:flutter/material.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/widgets/circular_progress_ring.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../../guide/domain/entities/completion_stats.dart';

/// Dashboard hero card: navy gradient background with animated progress ring.
class HeroCompletionGraph extends StatelessWidget {
  const HeroCompletionGraph({
    required this.stats,
    super.key,
  });

  final CompletionStats? stats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final percent = stats?.percent ?? 0.0;
    final label = stats != null ? '${(percent * 100).round()}%' : null;
    final completed = stats?.completedGuides ?? 0;
    final inProgress = stats?.inProgressGuides ?? 0;
    final hasData = stats != null && stats!.totalStepsAll > 0;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenH,
        vertical: AppSpacing.sm,
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: AppColors.heroGradient,
        borderRadius: AppSpacing.borderRadiusLgIncreased,
        boxShadow: AppSpacing.shadowMd,
      ),
      child: Column(
        children: [
          CircularProgressRing(
            percent: percent,
            size: 140,
            strokeWidth: 12,
            useGradient: true,
            trackColor: Colors.white.withValues(alpha: 0.15),
            label: label,
            progressColor: Colors.white,
          ),
          AppSpacing.gapVerticalSm,
          Text(
            l10n.monthlyCompletion,
            style: textTheme.titleMedium?.copyWith(
              color: Colors.white,
            ),
          ),
          if (hasData) ...[
            AppSpacing.gapVerticalXxs,
            Text(
              l10n.progressSummary(completed, inProgress),
              style: textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
