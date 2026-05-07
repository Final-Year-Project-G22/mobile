import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/guide_providers.dart';
import '../domain/entities/guide_card.dart';
import '../domain/entities/guide_category.dart';
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

    final catResult = await repo.getCategoryTree(null);
    final recentResult = await repo.getRecentlyViewed(null);
    final bkmkResult = await repo.listBookmarks();

    final categories = catResult.fold((_) => <GuideCategory>[], (c) => c);
    final recent = recentResult.fold((_) => <GuideCard>[], (r) => r);
    final bookmarks = bkmkResult.fold((_) => <StepBookmark>[], (b) => b);

    var allGuides = <GuideCard>[];
    for (final cat in categories) {
      allGuides.addAll(cat.guides);
    }

    if (allGuides.isEmpty) {
      final searchResult = await repo.searchGuides('', null);
      allGuides = searchResult.fold((_) => <GuideCard>[], (g) => g);
    }

    _allGuides = allGuides;

    state = state.copyWith(
      categories: categories,
      guides: allGuides,
      recentGuides: recent,
      bookmarks: bookmarks,
      isLoading: false,
    );
  }

  void search(String query) {
    if (query.isEmpty) {
      state = state.copyWith(searchQuery: '', selectedCategorySlug: '', guides: _allGuides);
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
        state = state.copyWith(guides: guides, isLoading: false, selectedCategorySlug: '');
      },
    );
  }

  void selectCategory(String slug) {
    if (slug.isEmpty) {
      state = state.copyWith(selectedCategorySlug: '', guides: _allGuides);
      return;
    }
    final cat = state.categories.firstWhere(
      (c) => c.slug == slug,
      orElse: () => state.categories.first,
    );
    final filtered = _allGuides.where((g) => g.categoryId == cat.id).toList();
    state = state.copyWith(selectedCategorySlug: slug, guides: filtered);
  }

  void toggleBookmarked() {
    state = state.copyWith(showBookmarked: !state.showBookmarked);
  }

  Future<void> refresh() async {
    await _loadData();
  }
}
