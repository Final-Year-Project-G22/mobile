import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'preferences_provider.dart';

part 'app_providers.g.dart';

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  @override
  ThemeMode build() {
    final prefsAsync = ref.watch(sharedPreferencesProviderFuture);
    return prefsAsync.when(
      data: (prefs) {
        final index = prefs.getInt('theme_mode_index') ?? 0;
        return [ThemeMode.system, ThemeMode.light, ThemeMode.dark][index];
      },
      loading: () => ThemeMode.system,
      error: (_, _) => ThemeMode.system,
    );
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
    ref.read(sharedPreferencesProviderFuture).whenData((prefs) {
      final index = [
        ThemeMode.system,
        ThemeMode.light,
        ThemeMode.dark,
      ].indexOf(mode);
      unawaited(prefs.setInt('theme_mode_index', index));
    });
  }
}

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale? build() {
    final prefsAsync = ref.watch(sharedPreferencesProviderFuture);
    return prefsAsync.when(
      data: (prefs) {
        final code = prefs.getString('locale_code');
        return code != null ? Locale(code) : null;
      },
      loading: () => null,
      error: (_, _) => null,
    );
  }

  void setLocale(Locale? locale) {
    state = locale;
    ref.read(sharedPreferencesProviderFuture).whenData((prefs) {
      if (locale != null) {
        unawaited(prefs.setString('locale_code', locale.languageCode));
      } else {
        unawaited(prefs.remove('locale_code'));
      }
    });
  }
}
