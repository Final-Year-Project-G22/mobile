import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/inbox_providers.dart';
import '../domain/failures/inbox_failure.dart';
import 'inbox_state.dart';
import 'unread_count_provider.dart';

part 'inbox_notifier.g.dart';

const _pageSize = 20;

@riverpod
class InboxNotifier extends _$InboxNotifier {
  @override
  InboxState build() => InboxState.initial();

  Future<void> loadInbox() async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      currentPage: 1,
      entries: [],
    );

    final repository = ref.read(inboxRepositoryProvider);
    final result = await repository.listInbox(
      page: 1,
      pageSize: _pageSize,
    );

    state = result.fold(
      (failure) => state.copyWith(
        isLoading: false,
        errorMessage: _mapFailure(failure),
      ),
      (data) => state.copyWith(
        isLoading: false,
        entries: data.entries,
        currentPage: data.page,
        total: data.total,
        hasMore: data.page < data.totalPages,
      ),
    );
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    final nextPage = state.currentPage + 1;

    state = state.copyWith(isLoadingMore: true, errorMessage: null);

    final repository = ref.read(inboxRepositoryProvider);
    final result = await repository.listInbox(
      page: nextPage,
      pageSize: _pageSize,
    );

    state = result.fold(
      (failure) => state.copyWith(
        isLoadingMore: false,
        errorMessage: _mapFailure(failure),
      ),
      (data) => state.copyWith(
        isLoadingMore: false,
        entries: [...state.entries, ...data.entries],
        currentPage: data.page,
        total: data.total,
        hasMore: data.page < data.totalPages,
      ),
    );
  }

  Future<void> markAsRead(String id) async {
    final repository = ref.read(inboxRepositoryProvider);
    final result = await repository.markAsRead(id);

    result.fold(
      (_) => null,
      (_) {
        final updated = state.entries.map((e) {
          if (e.id == id) return e.copyWith(isRead: true);
          return e;
        }).toList();
        state = state.copyWith(entries: updated);
        ref.invalidate(unreadCountProvider);
      },
    );
  }

  Future<void> markAllAsRead() async {
    final repository = ref.read(inboxRepositoryProvider);
    final result = await repository.markAllAsRead();

    result.fold(
      (_) => null,
      (_) {
        final updated = state.entries.map((e) => e.copyWith(isRead: true)).toList();
        state = state.copyWith(entries: updated);
        ref.invalidate(unreadCountProvider);
      },
    );
  }

  Future<void> refresh() async {
    await loadInbox();
    ref.invalidate(unreadCountProvider);
  }

  String _mapFailure(InboxFailure failure) {
    return failure.when(
      serverError: (msg) => msg ?? 'Server error. Please try again.',
      notFound: () => 'Not found.',
      unauthorized: () => 'Unauthorized. Please log in again.',
      invalidData: (msg) => msg ?? 'Invalid data.',
      networkError: () => 'Network error. Check your connection.',
    );
  }
}
