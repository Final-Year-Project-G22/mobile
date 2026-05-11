import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchTextNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setSearchText(String? text) => state = text;
}

final searchTextProvider = NotifierProvider<SearchTextNotifier, String?>(
  SearchTextNotifier.new,
);
