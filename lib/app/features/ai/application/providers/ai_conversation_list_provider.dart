import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/conversation_list_result.dart';
import 'ai_providers.dart';

part 'ai_conversation_list_provider.g.dart';

@riverpod
class ConversationListNotifier extends _$ConversationListNotifier {
  static const pageSize = 20;

  ConversationListResult? _cachedResult;
  bool _hasMore = true;
  bool _loadingMore = false;

  @override
  Future<ConversationListResult> build() async {
    return _loadPage(limit: pageSize, offset: 0);
  }

  Future<ConversationListResult> _loadPage({
    required int limit,
    required int offset,
  }) async {
    final repository = ref.read(aiRepositoryProvider);
    final result = await repository.listConversations(
      limit: limit,
      offset: offset,
    );

    return result.fold(
      (failure) => throw Exception(failure.toString()),
      (data) => data,
    );
  }

  Future<void> loadMore() async {
    if (_loadingMore || !_hasMore || state.value == null) return;

    _loadingMore = true;
    final current = state.value!;
    final nextOffset = current.sessions.length;

    if (nextOffset >= current.total) {
      _hasMore = false;
      _loadingMore = false;
      return;
    }

    final result = await _loadPage(
      limit: pageSize,
      offset: nextOffset,
    );

    final mergedSessions = [...current.sessions, ...result.sessions];
    _cachedResult = ConversationListResult(
      sessions: mergedSessions,
      total: result.total,
    );
    _hasMore = mergedSessions.length < result.total;
    _loadingMore = false;

    state = AsyncValue.data(_cachedResult!);
  }

  Future<void> refresh() async {
    _cachedResult = null;
    _hasMore = true;
    _loadingMore = false;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _loadPage(
        limit: pageSize,
        offset: 0,
      ),
    );
    if (state.value case final value?) {
      _cachedResult = value;
      _hasMore = value.sessions.length < value.total;
    }
  }

  Future<void> archiveConversation(String sessionId) async {
    final repository = ref.read(aiRepositoryProvider);
    final result = await repository.archiveConversation(sessionId);

    result.fold(
      (failure) {
        state = AsyncValue.error(
          Exception(failure.toString()),
          StackTrace.current,
        );
      },
      (_) {
        if (_cachedResult != null) {
          final filtered = _cachedResult!.sessions
              .where((s) => s.id != sessionId)
              .toList();
          _cachedResult = ConversationListResult(
            sessions: filtered,
            total: _cachedResult!.total - 1,
          );
          state = AsyncValue.data(_cachedResult!);
        } else {
          ref.invalidateSelf();
        }
      },
    );
  }

  bool get isLoadingMore => _loadingMore;
}
