import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/widgets/circular_progress_ring.dart';
import '../../../../constants/app_spacing.dart';
import '../../../guide/domain/entities/completion_stats.dart';
import '../../../guide/domain/entities/guide_card.dart';
import '../../../guide/domain/entities/guide_with_progress.dart';
import '../../../guide/presentation/widgets/recent_guide_rail.dart';
import '../../../notifications/compliance/presentation/widgets/compliance_calendar_widget.dart';
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
    final hasNoData =
        (completionStats == null || completionStats!.totalStepsAll == 0) &&
        inProgressGuides.isEmpty &&
        recentlyViewed.isEmpty;

    return RefreshIndicator(
      onRefresh: onRefresh ?? () async {},
      child: ListView(
        children: [
          HeroCompletionGraph(stats: completionStats),
          if (hasNoData) const _EmptyWelcome(),
          const SizedBox(height: AppSpacing.sectionGap),
          QuickActionsGrid(actions: quickActions),
          const SizedBox(height: AppSpacing.sectionGap),
          ComplianceCalendarWidget(
            onSeeAll: () => context.push('/inbox'),
          ),
          const SizedBox(height: AppSpacing.sectionGap),
          ContinueWhereYouLeftOffRail(
            guides: inProgressGuides,
            onGuideTap: onGuideTap,
          ),
          if (recentlyViewed.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sectionGap),
            RecentGuideRail(guides: recentlyViewed),
          ],
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

class _EmptyWelcome extends StatelessWidget {
  const _EmptyWelcome();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

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
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
