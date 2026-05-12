import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../router/routes.dart';
import '../../application/home_dashboard_notifier.dart';
import '../widgets/home_dashboard_content.dart';
import '../widgets/quick_actions_grid.dart';

class HomeDashboardPage extends ConsumerWidget {
  const HomeDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeDashboardProvider);

    if (state.isLoading && state.completionStats == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final actions = <QuickAction>[
      if (state.recentlyViewed.isNotEmpty)
        QuickAction(
          icon: Icons.play_circle_outline,
          label: 'Continue Last Guide',
          onTap: () => GuideDetailRoute(
            guideSlug: state.recentlyViewed.first.slug,
          ).go(context),
        ),
      QuickAction(
        icon: Icons.history,
        label: 'Continue Chat',
        onTap: () => context.push('/ai-guide'),
      ),
      QuickAction(
        icon: Icons.inbox_outlined,
        label: 'Inbox',
        onTap: () => context.push('/inbox'),
      ),
      QuickAction(
        icon: Icons.person_outline,
        label: 'Profile',
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
