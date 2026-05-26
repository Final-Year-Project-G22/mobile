import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/guide_providers.dart';
import '../../guide/domain/entities/guide_card.dart';
import '../../guide/domain/entities/guide_with_progress.dart';
import 'home_dashboard_state.dart';

part 'home_dashboard_notifier.g.dart';

@riverpod
class HomeDashboardNotifier extends _$HomeDashboardNotifier {
  @override
  HomeDashboardState build() {
    unawaited(_loadData());
    return const HomeDashboardState(isLoading: true);
  }

  Future<void> _loadData() async {
    final repo = ref.read(guideRepositoryProvider);

    final statsResult = await repo.getCompletionStats();
    final inProgressResult = await repo.getInProgressGuides();
    final recentResult = await repo.getRecentlyViewed();

    final statsFailure = statsResult.fold(
      (f) => f.toString(),
      (_) => null,
    );
    final stats = statsResult.fold((_) => null, (s) => s);
    final inProgress = inProgressResult.fold(
      (_) => <GuideWithProgress>[],
      (r) => r,
    );
    final recent = recentResult.fold((_) => <GuideCard>[], (r) => r);

    state = HomeDashboardState(
      completionStats: stats,
      inProgressGuides: inProgress,
      recentlyViewed: recent,
      errorMessage: (stats == null && inProgress.isEmpty && recent.isEmpty)
          ? (statsFailure ?? 'Failed to load dashboard')
          : null,
    );
  }

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, clearError: true);
    await _loadData();
  }
}
