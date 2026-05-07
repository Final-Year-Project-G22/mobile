import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/entities/inbox_entry.dart';

part 'inbox_state.freezed.dart';

@freezed
abstract class InboxState with _$InboxState {
  const factory InboxState({
    @Default([]) List<InboxEntry> entries,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasMore,
    @Default(0) int currentPage,
    @Default(0) int total,
    String? errorMessage,
  }) = _InboxState;

  factory InboxState.initial() => const InboxState();
}
