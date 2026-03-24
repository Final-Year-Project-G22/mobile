import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_providers.g.dart';

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() => ThemeMode.system;

  void setThemeMode(ThemeMode mode) {
    state = mode;
  }
}

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale? build() => null;

  void setLocale(Locale? locale) {
    state = locale;
  }
}
