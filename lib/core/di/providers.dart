import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../network/app_network_info.dart';
import '../../features/auth/application/auth_facade.dart';
import '../../features/auth/application/auth_notifier.dart';
import '../../features/auth/application/auth_state.dart';
import '../../features/auth/domain/i_auth_facade.dart';
import '../../features/auth/domain/i_auth_repository.dart';
import '../../features/auth/infrastructure/auth_repository_impl.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(
    baseUrl: 'http://localhost:4000', // replace for device/emulator as needed
    enableLogging: true,
  );
});
final dioProvider = Provider<Dio>((ref) {
  return ref.watch(apiClientProvider).dio;
});

final authenticationClientProvider = Provider<AuthenticationClient>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthenticationClient(dio);
});

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final client = ref.watch(authenticationClientProvider);
  return AuthRepositoryImpl(client);
});

final authFacadeProvider = Provider<IAuthFacade>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthFacade(repository);
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((
  ref,
) {
  final facade = ref.watch(authFacadeProvider);
  return AuthNotifier(facade);
});

final networkInfoProvider = Provider<AppNetworkInfo>((ref) {
  return AppNetworkInfo();
});

class LocaleNotifier extends Notifier<Locale?> {
  @override
  Locale? build() => null;

  void setLocale(Locale? locale) {
    state = locale;
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale?>(
  LocaleNotifier.new,
);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.system;

  void setThemeMode(ThemeMode mode) {
    state = mode;
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

final isNetworkConnectedProvider = StreamProvider<bool>((ref) {
  return ref.watch(networkInfoProvider).onConnectivityChanged;
});
