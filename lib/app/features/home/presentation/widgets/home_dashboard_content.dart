import 'package:flutter/material.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/widgets/circular_progress_ring.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../../guide/domain/entities/completion_stats.dart';
import '../../../guide/domain/entities/guide_card.dart';
import '../../../guide/domain/entities/guide_with_progress.dart';
import '../../../guide/presentation/widgets/recent_guide_rail.dart';
import 'continue_where_you_left_off.dart';
import 'hero_completion_graph.dart';
import 'quick_actions_grid.dart';

class HomeDashboardContent extends StatelessWidget {
  const HomeDashboardContent({
    required this.completionStats,
    required this.inProgressGuides,
    required this.recentlyViewed,
    required this.quickActions,
    required this.onGuideTap,
    this.onRefresh,
    super.key,
  });

  final CompletionStats? completionStats;
  final List<GuideWithProgress> inProgressGuides;
  final List<GuideCard> recentlyViewed;
  final List<QuickAction> quickActions;
  final void Function(String guideSlug) onGuideTap;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasNoData =
        (completionStats == null || completionStats!.totalStepsAll == 0) &&
        inProgressGuides.isEmpty &&
        recentlyViewed.isEmpty;

    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: ListView(
        children: [
          HeroCompletionGraph(stats: completionStats),
          if (hasNoData) _EmptyWelcome(isDark: isDark),
          QuickActionsGrid(actions: quickActions),
          AppSpacing.gapVerticalMd,
          ContinueWhereYouLeftOffRail(
            guides: inProgressGuides,
            onGuideTap: onGuideTap,
          ),
          if (recentlyViewed.isNotEmpty) ...[
            AppSpacing.gapVerticalMd,
            RecentGuideRail(guides: recentlyViewed),
          ],
          AppSpacing.gapVerticalLg,
        ],
      ),
    );
  }
}

class _EmptyWelcome extends StatelessWidget {
  const _EmptyWelcome({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Column(
        children: [
          const CircularProgressRing(
            percent: 0,
            size: 64,
            strokeWidth: 6,
            label: '0%',
          ),
          AppSpacing.gapVerticalSm,
          Text(
            l10n.dashboardEmptyMessage,
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondaryLight,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
