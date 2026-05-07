import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/entities/guide_card.dart' as entity;
import '../infrastructure/guide_dummy_data.dart';
import 'guide_state.dart';

part 'guide_list_notifier.g.dart';

@riverpod
class GuideListNotifier extends _$GuideListNotifier {
  @override
  GuideListState build() {
    return GuideListState(
      categories: GuideDummyData.getCategoryTree(),
      guides: GuideDummyData.getAllGuideCards(),
      recentGuides: GuideDummyData.recentGuides,
      bookmarks: GuideDummyData.bookmarks,
    );
  }

  void search(String query) {
    state = state.copyWith(
      searchQuery: query,
      guides: GuideDummyData.searchGuides(query),
    );
  }

  void selectCategory(String? slug) {
    final allGuides = GuideDummyData.getAllGuideCards();
    final List<entity.GuideCard> filtered;
    if (slug == null) {
      filtered = allGuides;
    } else {
      final cat = GuideDummyData.categories.firstWhere((c) => c.slug == slug);
      filtered = allGuides.where((g) => g.categoryId == cat.id).toList();
    }
    state = state.copyWith(
      selectedCategorySlug: slug,
      guides: filtered,
    );
  }

  void toggleBookmarked() {
    state = state.copyWith(showBookmarked: !state.showBookmarked);
  }

  void refresh() {
    state = state.copyWith(
      categories: GuideDummyData.getCategoryTree(),
    );
  }
}
