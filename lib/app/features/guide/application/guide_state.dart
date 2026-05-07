import '../domain/entities/guide_card.dart';
import '../domain/entities/guide_category.dart';
import '../domain/entities/step_bookmark.dart';

class GuideListState {
  const GuideListState({
    this.categories = const [],
    this.guides = const [],
    this.recentGuides = const [],
    this.bookmarks = const [],
    this.searchQuery = '',
    this.selectedCategorySlug,
    this.showBookmarked = false,
    this.isLoading = false,
  });

  final List<GuideCategory> categories;
  final List<GuideCard> guides;
  final List<GuideCard> recentGuides;
  final List<StepBookmark> bookmarks;
  final String searchQuery;
  final String? selectedCategorySlug;
  final bool showBookmarked;
  final bool isLoading;

  GuideListState copyWith({
    List<GuideCategory>? categories,
    List<GuideCard>? guides,
    List<GuideCard>? recentGuides,
    List<StepBookmark>? bookmarks,
    String? searchQuery,
    String? selectedCategorySlug,
    bool? showBookmarked,
    bool? isLoading,
  }) {
    return GuideListState(
      categories: categories ?? this.categories,
      guides: guides ?? this.guides,
      recentGuides: recentGuides ?? this.recentGuides,
      bookmarks: bookmarks ?? this.bookmarks,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategorySlug: selectedCategorySlug ?? this.selectedCategorySlug,
      showBookmarked: showBookmarked ?? this.showBookmarked,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
