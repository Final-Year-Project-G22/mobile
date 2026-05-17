import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/widgets/adisu_progress_indicator.dart';
import '../../../../../shared/widgets/error_view.dart';
import '../../../../router/routes.dart';
import '../../application/home_dashboard_notifier.dart';
import '../widgets/home_dashboard_content.dart';
import '../widgets/quick_actions_grid.dart';

class HomeDashboardPage extends ConsumerWidget {
  const HomeDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeDashboardProvider);
    final l10n = AppLocalizations.of(context);

    if (state.isLoading && state.completionStats == null) {
      return const Center(child: AdisuProgressIndicator.large());
    }

    if (state.hasError && state.completionStats == null) {
      return ErrorView(
        message: state.errorMessage!,
        onRetry: () => ref.read(homeDashboardProvider.notifier).refresh(),
        retryLabel: l10n.retry,
      );
    }

    final actions = <QuickAction>[
      if (state.recentlyViewed.isNotEmpty)
        QuickAction(
          icon: Icons.play_circle_outline,
          label: l10n.continueLastGuide,
          onTap: () => GuideDetailRoute(
            guideSlug: state.recentlyViewed.first.slug,
          ).go(context),
        ),
      QuickAction(
        icon: Icons.history,
        label: l10n.continueChat,
        onTap: () => context.push('/ai-guide'),
      ),
      QuickAction(
        icon: Icons.inbox_outlined,
        label: l10n.inbox,
        onTap: () => context.push('/inbox'),
      ),
      QuickAction(
        icon: Icons.person_outline,
        label: l10n.profile,
        onTap: () => context.push('/profile'),
      ),
    ];

    return HomeDashboardContent(
      completionStats: state.completionStats,
      inProgressGuides: state.inProgressGuides,
      recentlyViewed: state.recentlyViewed,
      onGuideTap: (slug) => GuideDetailRoute(guideSlug: slug).go(context),
      onRefresh: () => ref.read(homeDashboardProvider.notifier).refresh(),
      quickActions: actions,
    );
  }
}
