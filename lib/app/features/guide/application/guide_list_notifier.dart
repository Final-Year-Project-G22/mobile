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

  @override
  GuideListState build() {
    unawaited(_loadData());
    return const GuideListState(isLoading: true);
  }

  Future<void> _loadData() async {
    final repo = ref.read(guideRepositoryProvider);

    final recentResult = await repo.getRecentlyViewed(null);
    final bkmkResult = await repo.listBookmarks();

    final recent = recentResult.fold((_) => <GuideCard>[], (r) => r);
    final bookmarks = bkmkResult.fold((_) => <StepBookmark>[], (b) => b);

    final listResult = await repo.listGuides();
    final allGuides = listResult.fold((_) => <GuideCard>[], (g) => g);

    _allGuides = allGuides;

    state = state.copyWith(
      guides: allGuides,
      recentGuides: recent,
      bookmarks: bookmarks,
      isLoading: false,
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
    final result = await repo.searchGuides(query, null);
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
    state = GuideListState(
      guides: _allGuides,
      recentGuides: state.recentGuides,
      bookmarks: state.bookmarks,
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
