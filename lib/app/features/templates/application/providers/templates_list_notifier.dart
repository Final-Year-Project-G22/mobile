import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/template_group.dart';
import '../../domain/i_templates_repository.dart';
import 'templates_providers.dart';

part 'templates_list_notifier.freezed.dart';
part 'templates_list_notifier.g.dart';

@freezed
abstract class TemplateListState with _$TemplateListState {
  const factory TemplateListState({
    @Default(<TemplateGroup>[]) List<TemplateGroup> items,
    @Default(1) int page,
    @Default(true) bool hasMore,
    @Default(false) bool isLoadingMore,
    String? searchQuery,
    String? categoryId,
  }) = _TemplateListState;
}

@riverpod
class TemplateListNotifier extends _$TemplateListNotifier {
  static const _pageSize = 20;

  @override
  Future<TemplateListState> build() async {
    return _loadPage(
      const TemplateListState(),
      page: 1,
    );
  }

  Future<void> loadMore() async {
    final current = state.valueOrNull;
    if (current == null || current.isLoadingMore || !current.hasMore) return;

    state = AsyncValue.data(current.copyWith(isLoadingMore: true));

    final nextPage = current.page + 1;
    final result = await _fetchPage(
      page: nextPage,
      searchQuery: current.searchQuery,
      categoryId: current.categoryId,
    );

    state = await result.fold(
      (failure) => Future.value(
        AsyncValue.error(failure, StackTrace.current),
      ),
      (newItems) => Future.value(
        AsyncValue.data(
          current.copyWith(
            items: [...current.items, ...newItems],
            page: nextPage,
            hasMore: newItems.length >= _pageSize,
            isLoadingMore: false,
          ),
        ),
      ),
    );
  }

  Future<void> setSearch(String? query) async {
    final current = state.valueOrNull;
    final normalized = query?.trim();
    final effectiveQuery = normalized?.isEmpty == true ? null : normalized;

    if (current != null && current.searchQuery == effectiveQuery) return;

    state = const AsyncValue.loading();
    state = await _loadPage(
      TemplateListState(searchQuery: effectiveQuery),
      page: 1,
    );
  }

  Future<void> setCategory(String? categoryId) async {
    final current = state.valueOrNull;
    if (current != null && current.categoryId == categoryId) return;

    state = const AsyncValue.loading();
    state = await _loadPage(
      TemplateListState(categoryId: categoryId),
      page: 1,
    );
  }

  Future<void> refresh() async {
    final current = state.valueOrNull;
    state = const AsyncValue.loading();
    state = await _loadPage(
      current ?? const TemplateListState(),
      page: 1,
    );
  }

  Future<AsyncValue<TemplateListState>> _loadPage(
    TemplateListState baseState, {
    required int page,
  }) async {
    final result = await _fetchPage(
      page: page,
      searchQuery: baseState.searchQuery,
      categoryId: baseState.categoryId,
    );

    return result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (items) => AsyncValue.data(
        baseState.copyWith(
          items: items,
          page: page,
          hasMore: items.length >= _pageSize,
          isLoadingMore: false,
        ),
      ),
    );
  }

  Future<Either<TemplateFailure, List<TemplateGroup>>> _fetchPage({
    required int page,
    String? searchQuery,
    String? categoryId,
  }) async {
    final repository = ref.read(templatesRepositoryProvider);
    return repository.listTemplateGroups(
      categoryId: categoryId,
      search: searchQuery,
      page: page,
      pageSize: _pageSize,
    );
  }
}
