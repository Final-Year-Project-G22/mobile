import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../features/notifications/application/sse_inbox_listener.dart';
import '../../../../router/routes.dart';
import '../../../business_profile/application/business_profile_notifier.dart';
import '../../../business_profile/presentation/widgets/complete_profile_banner.dart';
import '../../application/home_tab_notifier.dart';

import '../widgets/home_top_actions.dart';

class HomeShellPage extends ConsumerStatefulWidget {
  const HomeShellPage({required this.navigator, super.key});

  final Widget navigator;

  @override
  ConsumerState<HomeShellPage> createState() => _HomeShellPageState();
}

class _HomeShellPageState extends ConsumerState<HomeShellPage> {
  @override
  void initState() {
    super.initState();
    unawaited(
      Future.microtask(() async {
        await ref.read(businessProfileProvider.notifier).refreshProfile();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(homeTabIndexProvider);
    final unreadCountAsync = ref.watch(notificationBadgeCountProvider);
    final businessProfileAsync = ref.watch(businessProfileProvider);
    final theme = Theme.of(context);
    final navigator = widget.navigator;
    final l10n = AppLocalizations.of(context);

    final tabLabels = [
      l10n.home,
      l10n.guide,
      l10n.community,
      l10n.aiGuideTitle,
      l10n.templates,
    ];

    final routerState = GoRouterState.of(context);
    final currentPath = routerState.matchedLocation;
    final isTabRoot = [
      '/home',
      '/guides',
      '/community',
      '/templates',
      '/downloads',
    ].any((tabPath) => currentPath == tabPath);

    return Scaffold(
      appBar: isTabRoot
          ? AppBar(
              title: Text(
                tabLabels[currentIndex],
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
            )
          : null,
      body: Column(
        children: [
          if (businessProfileAsync.hasValue &&
              businessProfileAsync.value == null)
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
              context.go('/guides');
            case 2:
              ref.read(homeTabIndexProvider.notifier).setIndex(2);
              context.go('/community');
            case 3:
              unawaited(context.push('/ai-guide'));
            case 4:
              ref.read(homeTabIndexProvider.notifier).setIndex(4);
              context.go('/templates');
          }
        },
        destinations: homeTabSpecs.asMap().entries.map(
          (entry) {
            final tab = entry.value;
            return NavigationDestination(
              icon: Icon(tab.icon),
              selectedIcon: Icon(tab.selectedIcon),
              label: tabLabels[entry.key],
            );
          },
        ).toList(),
      ),
    );
  }
}
