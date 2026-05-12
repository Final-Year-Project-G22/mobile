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

    return HomeDashboardContent(
      completionStats: state.completionStats,
      inProgressGuides: state.inProgressGuides,
      recentlyViewed: state.recentlyViewed,
      onGuideTap: (slug) => GuideDetailRoute(guideSlug: slug).go(context),
      onRefresh: () => ref.read(homeDashboardProvider.notifier).refresh(),
      quickActions: [
        QuickAction(
          icon: Icons.menu_book,
          label: 'Start Guide',
          onTap: () => const GuidesRoute().go(context),
        ),
        QuickAction(
          icon: Icons.auto_awesome,
          label: 'Ask AI',
          onTap: () => context.push('/ai-guide'),
        ),
        QuickAction(
          icon: Icons.groups,
          label: 'Community',
          onTap: () => const CommunityHomeRoute().go(context),
        ),
        QuickAction(
          icon: Icons.grid_view,
          label: 'Browse Templates',
          onTap: () => const TemplatesRoute().go(context),
        ),
      ],
    );
  }
}
