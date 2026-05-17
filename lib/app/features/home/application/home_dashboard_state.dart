import '../../guide/domain/entities/completion_stats.dart';
import '../../guide/domain/entities/guide_card.dart';
import '../../guide/domain/entities/guide_with_progress.dart';

class HomeDashboardState {
  const HomeDashboardState({
    this.completionStats,
    this.inProgressGuides = const [],
    this.recentlyViewed = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  final CompletionStats? completionStats;
  final List<GuideWithProgress> inProgressGuides;
  final List<GuideCard> recentlyViewed;
  final bool isLoading;
  final String? errorMessage;

  bool get hasError => errorMessage != null;

  HomeDashboardState copyWith({
    CompletionStats? completionStats,
    List<GuideWithProgress>? inProgressGuides,
    List<GuideCard>? recentlyViewed,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return HomeDashboardState(
      completionStats: completionStats ?? this.completionStats,
      inProgressGuides: inProgressGuides ?? this.inProgressGuides,
      recentlyViewed: recentlyViewed ?? this.recentlyViewed,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
