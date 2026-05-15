import 'package:flutter/material.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/widgets/circular_progress_ring.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../../guide/domain/entities/completion_stats.dart';

class HeroCompletionGraph extends StatelessWidget {
  const HeroCompletionGraph({
    required this.stats,
    super.key,
  });

  final CompletionStats? stats;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final percent = stats?.percent ?? 0.0;
    final label = stats != null ? '${(percent * 100).round()}%' : null;
    final completed = stats?.completedGuides ?? 0;
    final inProgress = stats?.inProgressGuides ?? 0;
    final hasData = stats != null && stats!.totalStepsAll > 0;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Column(
        children: [
          CircularProgressRing(
            percent: percent,
            label: label,
          ),
          AppSpacing.gapVerticalSm,
          Text(
            l10n.monthlyCompletion,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          if (hasData) ...[
            AppSpacing.gapVerticalXxs,
            Text(
              l10n.progressSummary(completed, inProgress),
              style: TextStyle(
                fontSize: 13,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
