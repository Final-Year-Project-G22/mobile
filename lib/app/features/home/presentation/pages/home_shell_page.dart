import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:mobile/app/constants/app_spacing.dart';
import 'package:mobile/app/features/home/application/home_tab_notifier.dart';

import '../widgets/home_top_actions.dart';
import 'ai_guild_page.dart';
import 'community_page.dart';
import 'guide_page.dart';
import 'templates_page.dart';

class HomeShellPage extends ConsumerWidget {
  const HomeShellPage({super.key});

  static const List<Widget> _tabPages = [
    GuidePage(),
    CommunityPage(),
    AiGuildPage(),
    TemplatesPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(homeTabIndexProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          homeTabSpecs[currentIndex].label,
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          HomeTopActions(
            onNotificationsTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications coming soon')),
              );
            },
            onProfileTap: () => context.push('/profile'),
          ),
          AppSpacing.gapHorizontalXs,
        ],
      ),
      body: IndexedStack(index: currentIndex, children: _tabPages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          ref.read(homeTabIndexProvider.notifier).setIndex(index);
        },
        destinations: homeTabSpecs
            .map(
              (tab) => NavigationDestination(
                icon: Icon(tab.icon),
                selectedIcon: Icon(tab.selectedIcon),
                label: tab.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
