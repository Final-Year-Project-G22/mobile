import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/di/preferences_provider.dart';
import '../../domain/failures/template_failure.dart';
import '../../infrastructure/cache/downloads_cache_service.dart';
import 'templates_providers.dart';

part 'downloads_notifier.freezed.dart';
part 'downloads_notifier.g.dart';

@freezed
abstract class EnrichedDownloadItem with _$EnrichedDownloadItem {
  const factory EnrichedDownloadItem({
    required String id,
    required String templateId,
    required String groupId,
    required DateTime downloadedAt,
    String? title,
    String? slug,
    String? thumbnailUrl,
  }) = _EnrichedDownloadItem;
}

@freezed
abstract class DownloadsState with _$DownloadsState {
  const factory DownloadsState({
    @Default(<EnrichedDownloadItem>[]) List<EnrichedDownloadItem> items,
    @Default(1) int page,
    @Default(true) bool hasMore,
    @Default(false) bool isLoadingMore,
  }) = _DownloadsState;
}

@riverpod
class MyDownloadsNotifier extends _$MyDownloadsNotifier {
  static const _pageSize = 20;

  @override
  Future<DownloadsState> build() async {
    return _loadPage(const DownloadsState(), page: 1);
  }

  Future<void> loadMore() async {
    final current = await future;
    if (current.isLoadingMore || !current.hasMore) return;

    state = AsyncValue.data(current.copyWith(isLoadingMore: true));

    final nextPage = current.page + 1;
    final result = await _fetchPage(nextPage);

    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (newItems) => AsyncValue.data(
        current.copyWith(
          items: [...current.items, ...newItems],
          page: nextPage,
          hasMore: newItems.length >= _pageSize,
          isLoadingMore: false,
        ),
      ),
    );
  }

  Future<void> refresh() async {
    final current = await future;
    state = const AsyncValue.loading();
    state = AsyncValue.data(
      await _loadPage(
        current,
        page: 1,
      ),
    );
  }

  Future<DownloadsState> _loadPage(
    DownloadsState baseState, {
    required int page,
  }) async {
    final result = await _fetchPage(page);

    return result.fold(
      (failure) => throw failure,
      (items) => baseState.copyWith(
        items: items,
        page: page,
        hasMore: items.length >= _pageSize,
        isLoadingMore: false,
      ),
    );
  }

  Future<Either<TemplateFailure, List<EnrichedDownloadItem>>> _fetchPage(
    int page,
  ) async {
    final repository = ref.read(templatesRepositoryProvider);

    final result = await repository.listMyDownloads(
      page: page,
      pageSize: _pageSize,
    );

    // Enrich with cached metadata if SharedPreferences are loaded.
    DownloadsCacheService? cache;
    try {
      final prefs = await ref.read(sharedPreferencesProviderFuture.future);
      cache = DownloadsCacheService(prefs);
    } on Exception {
      cache = null;
    }

    return result.map(
      (items) => items.map((item) {
        final cached = cache?.findByGroupId(item.groupId);
        return EnrichedDownloadItem(
          id: item.id,
          templateId: item.templateId,
          groupId: item.groupId,
          downloadedAt: item.downloadedAt,
          title: cached?.title,
          slug: cached?.slug,
          thumbnailUrl: cached?.thumbnailUrl,
        );
      }).toList(),
    );
  }
}
