import '../../guide/domain/entities/completion_stats.dart';
import '../../guide/domain/entities/guide_card.dart';
import '../../guide/domain/entities/guide_with_progress.dart';

class HomeDashboardState {
  const HomeDashboardState({
    this.completionStats,
    this.inProgressGuides = const [],
    this.recentlyViewed = const [],
    this.isLoading = false,
  });

  final CompletionStats? completionStats;
  final List<GuideWithProgress> inProgressGuides;
  final List<GuideCard> recentlyViewed;
  final bool isLoading;

  HomeDashboardState copyWith({
    CompletionStats? completionStats,
    List<GuideWithProgress>? inProgressGuides,
    List<GuideCard>? recentlyViewed,
    bool? isLoading,
  }) {
    return HomeDashboardState(
      completionStats: completionStats ?? this.completionStats,
      inProgressGuides: inProgressGuides ?? this.inProgressGuides,
      recentlyViewed: recentlyViewed ?? this.recentlyViewed,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
