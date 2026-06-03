import '../domain/entities/guide_card.dart';
import '../domain/entities/step_bookmark.dart';

enum GuideTab { forYou, all }

class GuideListState {
  const GuideListState({
    this.guides = const [],
    this.recentGuides = const [],
    this.bookmarks = const [],
    this.searchQuery = '',
    this.selectedSectorId,
    this.selectedTagIds = const [],
    this.showBookmarked = false,
    this.selectedTab = GuideTab.forYou,
    this.isLoading = false,
    this.isFiltering = false,
    this.hasError = false,
  });

  final List<GuideCard> guides;
  final List<GuideCard> recentGuides;
  final List<StepBookmark> bookmarks;
  final String searchQuery;
  final String? selectedSectorId;
  final List<String> selectedTagIds;
  final bool showBookmarked;
  final GuideTab selectedTab;
  final bool isLoading;
  final bool isFiltering;
  final bool hasError;

  bool get hasActiveFilters =>
      selectedSectorId != null || selectedTagIds.isNotEmpty;

  GuideListState copyWith({
    List<GuideCard>? guides,
    List<GuideCard>? recentGuides,
    List<StepBookmark>? bookmarks,
    String? searchQuery,
    String? selectedSectorId,
    List<String>? selectedTagIds,
    bool? showBookmarked,
    GuideTab? selectedTab,
    bool? isLoading,
    bool? isFiltering,
    bool? hasError,
  }) {
    return GuideListState(
      guides: guides ?? this.guides,
      recentGuides: recentGuides ?? this.recentGuides,
      bookmarks: bookmarks ?? this.bookmarks,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedSectorId: selectedSectorId ?? this.selectedSectorId,
      selectedTagIds: selectedTagIds ?? this.selectedTagIds,
      showBookmarked: showBookmarked ?? this.showBookmarked,
      selectedTab: selectedTab ?? this.selectedTab,
      isLoading: isLoading ?? this.isLoading,
      isFiltering: isFiltering ?? this.isFiltering,
      hasError: hasError ?? this.hasError,
    );
  }
}
