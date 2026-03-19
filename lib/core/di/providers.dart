import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/core/auth/token_storage.dart';

import '../network/app_network_info.dart';
import '../../features/auth/application/auth_facade.dart';
import '../../features/auth/application/auth_notifier.dart';
import '../../features/auth/application/auth_state.dart';
import '../../features/auth/domain/i_auth_facade.dart';
import '../../features/auth/domain/i_auth_repository.dart';
import '../../features/auth/infrastructure/auth_repository_impl.dart';
class AuthSessionNotifier extends Notifier<bool> {
  @override
  bool build() => false;
  void setAuthenticated() => state = true;
  void setUnauthenticated() => state = false;
}
final authSessionProvider = NotifierProvider<AuthSessionNotifier, bool>(
  AuthSessionNotifier.new,
);
final apiClientProvider = Provider<ApiClient>((ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);
  final baseUrl = dotenv.env['API_BASE_URL'];
  if (baseUrl == null) {
    throw Exception('API_BASE_URL not set');
  }
  late ApiClient apiClient;
  apiClient = ApiClient(
    baseUrl: baseUrl ,
    enableLogging: true,
    onUnauthorized: () async {
      await tokenStorage.clear();
      apiClient.clearTokens();
      ref.read(authSessionProvider.notifier).setUnauthenticated();
    },
    onTokenRefreshed: (tokens) async {
      await tokenStorage.saveTokens(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
        expiresAt: tokens.expiresAt,
      );
    },
  );
  return apiClient;
});
final authBootstrapProvider = FutureProvider<void>((ref) async {
  final tokenStorage = ref.read(tokenStorageProvider);
  final apiClient = ref.read(apiClientProvider);
  final stored = await tokenStorage.readTokens();
  if (stored == null) {
    ref.read(authSessionProvider.notifier).setUnauthenticated();
    return;
  }
  apiClient.setTokens(stored.accessToken, stored.refreshToken);
  ref.read(authSessionProvider.notifier).setAuthenticated();
});

final dioProvider = Provider<Dio>((ref) {
  return ref.watch(apiClientProvider).dio;
});
final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});
final tokenStorageProvider = Provider<TokenStorage>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return TokenStorage(storage);
});

final authenticationClientProvider = Provider<AuthenticationClient>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthenticationClient(dio);
});

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final client = ref.watch(authenticationClientProvider);
   final apiClient = ref.watch(apiClientProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);
  return AuthRepositoryImpl(client,apiClient,tokenStorage);
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
