import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/guide_providers.dart';
import '../domain/entities/guide_card.dart';
import '../domain/entities/step_bookmark.dart';
import 'guide_state.dart';

part 'guide_list_notifier.g.dart';

@riverpod
class GuideListNotifier extends _$GuideListNotifier {
  var _allGuides = <GuideCard>[];
  var _forYouGuides = <GuideCard>[];

  @override
  GuideListState build() {
    unawaited(_loadData());
    return const GuideListState(isLoading: true);
  }

  Future<void> _loadData() async {
    final repo = ref.read(guideRepositoryProvider);

    try {
      final recentResult = await repo.getRecentlyViewed();
      final bkmkResult = await repo.listBookmarks();

      final recent = recentResult.fold((_) => <GuideCard>[], (r) => r);
      final bookmarks = bkmkResult.fold((_) => <StepBookmark>[], (b) => b);

      final forYouResult = await repo.listGuides();
      _forYouGuides = forYouResult.fold((_) => <GuideCard>[], (g) => g);

      final allResult = await repo.listAllGuides();
      _allGuides = allResult.fold((_) => <GuideCard>[], (g) => g);

      final guides = state.selectedTab == GuideTab.forYou
          ? _forYouGuides
          : _allGuides;

      final hasError = forYouResult.isLeft() || allResult.isLeft();

      state = state.copyWith(
        guides: guides,
        recentGuides: recent,
        bookmarks: bookmarks,
        isLoading: false,
        hasError: hasError,
      );
    } on Object catch (_) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
      );
    }
  }

  void switchTab(GuideTab tab) {
    if (tab == state.selectedTab) return;
    final guides = tab == GuideTab.forYou ? _forYouGuides : _allGuides;
    state = GuideListState(
      selectedTab: tab,
      guides: guides,
      recentGuides: state.recentGuides,
      bookmarks: state.bookmarks,
      hasError: state.hasError,
    );
  }

  void search(String query) {
    if (query.isEmpty) {
      _applyFilters();
      return;
    }
    state = state.copyWith(searchQuery: query, isLoading: true);
    unawaited(_runSearch(query));
  }

  Future<void> _runSearch(String query) async {
    final repo = ref.read(guideRepositoryProvider);
    final result = await repo.searchGuides(query);
    result.fold(
      (_) => state = state.copyWith(isLoading: false),
      (guides) {
        _allGuides = guides;
        _applyFilters();
      },
    );
  }

  void selectSector(String? sectorId) {
    state = state.copyWith(selectedSectorId: sectorId);
    unawaited(_applyFiltersAsync());
  }

  void toggleTag(String tagId) {
    final current = state.selectedTagIds;
    final updated = current.contains(tagId)
        ? current.where((id) => id != tagId).toList()
        : [...current, tagId];
    state = state.copyWith(selectedTagIds: updated);
    unawaited(_applyFiltersAsync());
  }

  void clearFilters() {
    final guides = state.selectedTab == GuideTab.forYou
        ? _forYouGuides
        : _allGuides;
    state = GuideListState(
      guides: guides,
      recentGuides: state.recentGuides,
      bookmarks: state.bookmarks,
      selectedTab: state.selectedTab,
      hasError: state.hasError,
    );
  }

  void _applyFilters() {
    if (state.searchQuery.isNotEmpty) {
      state = state.copyWith(guides: _allGuides, isLoading: false);
      return;
    }

    var filtered = _allGuides;

    if (state.selectedSectorId != null) {
      filtered = filtered
          .where((g) => g.sectorIds.contains(state.selectedSectorId))
          .toList();
    }

    if (state.selectedTagIds.isNotEmpty) {
      filtered = filtered
          .where(
            (g) => state.selectedTagIds.any(
              (tagId) => g.tagIds.contains(tagId),
            ),
          )
          .toList();
    }

    state = state.copyWith(
      guides: filtered,
      isLoading: false,
      isFiltering: state.hasActiveFilters,
    );
  }

  Future<void> _applyFiltersAsync() async {
    if (state.searchQuery.isNotEmpty) {
      state = state.copyWith(guides: _allGuides, isLoading: false);
      return;
    }

    if (!state.hasActiveFilters) {
      _applyFilters();
      return;
    }

    state = state.copyWith(isLoading: true);

    final repo = ref.read(guideRepositoryProvider);
    final result = await repo.listGuides(
      sectorIds: state.selectedSectorId != null
          ? [state.selectedSectorId!]
          : null,
      tagIds: state.selectedTagIds.isNotEmpty ? state.selectedTagIds : null,
    );

    result.fold(
      (_) => state = state.copyWith(isLoading: false),
      (guides) {
        state = state.copyWith(
          guides: guides,
          isLoading: false,
          isFiltering: true,
        );
      },
    );
  }

  void toggleBookmarked() {
    state = state.copyWith(showBookmarked: !state.showBookmarked);
  }

  Future<void> refresh() async {
    await _loadData();
  }
}
