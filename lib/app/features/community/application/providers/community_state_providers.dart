import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchTextNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setSearchText(String? text) => state = text;
}

final searchTextProvider = NotifierProvider<SearchTextNotifier, String?>(
  SearchTextNotifier.new,
);

class _SetNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => const {};

  void clear() => state = const {};
  void toggle(String id) {
    if (state.contains(id)) {
      state = state.difference({id});
    } else {
      state = state.union({id});
    }
  }
}

final selectedSectorIdsProvider =
    NotifierProvider<_SetNotifier, Set<String>>(_SetNotifier.new);
final selectedTagIdsProvider =
    NotifierProvider<_SetNotifier, Set<String>>(_SetNotifier.new);

class _BoolNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle({required bool value}) => state = value;
}

final showFollowedOnlyProvider =
    NotifierProvider<_BoolNotifier, bool>(_BoolNotifier.new);
