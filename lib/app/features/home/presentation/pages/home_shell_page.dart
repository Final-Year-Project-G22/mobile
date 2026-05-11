import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/app_spacing.dart';
import '../../../../features/notifications/application/unread_count_provider.dart';
import '../../../../router/routes.dart';
import '../../../business_profile/application/business_profile_notifier.dart';
import '../../../business_profile/presentation/widgets/complete_profile_banner.dart';
import '../../application/home_tab_notifier.dart';

import '../widgets/home_top_actions.dart';

class HomeShellPage extends ConsumerWidget {
  const HomeShellPage({required this.navigator, super.key});

  final Widget navigator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(homeTabIndexProvider);
    final unreadCountAsync = ref.watch(unreadCountProvider);
    final businessProfileAsync = ref.watch(businessProfileProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          homeTabSpecs[currentIndex].label,
          style: theme.textTheme.titleLarge,
        ),
        actions: [
          HomeTopActions(
            unreadCount: unreadCountAsync.value,
            onNotificationsTap: () => context.push('/inbox'),
            onProfileTap: () => context.push('/profile'),
          ),
          AppSpacing.gapHorizontalXs,
        ],
      ),
      body: Column(
        children: [
          if (businessProfileAsync.hasValue && businessProfileAsync.value == null)
            CompleteProfileBanner(
              onTap: () {
                const OnboardingRoute().go(context);
              },
            ),
          Expanded(child: navigator),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              ref.read(homeTabIndexProvider.notifier).setIndex(0);
              context.go('/home');
            case 1:
              ref.read(homeTabIndexProvider.notifier).setIndex(1);
              context.go('/community');
            case 2:
              unawaited(context.push('/ai-guide'));
            case 3:
              ref.read(homeTabIndexProvider.notifier).setIndex(3);
              context.go('/templates');
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
