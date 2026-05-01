import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/app_spacing.dart';
import '../../application/home_tab_notifier.dart';

import '../widgets/home_top_actions.dart';
import '../../../community/presentation/pages/community_home_page.dart';
import 'ai_guild_page.dart';
import 'guide_page.dart';
import 'templates_page.dart';

class HomeShellPage extends ConsumerWidget {
  const HomeShellPage({required this.navigator, super.key});

  final Widget navigator;

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
      body: navigator,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          ref.read(homeTabIndexProvider.notifier).setIndex(index);
          switch (index) {
            case 0:
              context.go('/home');
            case 1:
              context.go('/community');
            case 2:
              context.go('/ai-guild'); // Need to map these later
            case 3:
              context.go('/templates'); // Need to map these later
          }
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
