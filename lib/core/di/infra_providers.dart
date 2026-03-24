import 'package:api_client/api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile/core/auth/token_storage.dart';
import 'package:mobile/core/config/app_config.dart';
import 'package:mobile/core/network/app_network_info.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'infra_providers.g.dart';

@riverpod
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage();
}

@riverpod
TokenStorage tokenStorage(Ref ref) {
  return TokenStorage(ref.watch(secureStorageProvider));
}

@riverpod
ApiClient apiClient(Ref ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);

  final apiClient = ApiClient(baseUrl: AppConfig.apiBaseUrl, enableLogging: AppConfig.enableLogging);

  apiClient.setOnTokenRefreshedCallback((tokens) async {
    await tokenStorage.saveTokens(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
      expiresAt: tokens.expiresAt,
    );
  });

  return apiClient;
}

@riverpod
AppNetworkInfo networkInfo(Ref ref) {
  return AppNetworkInfo();
}

@riverpod
Stream<bool> isNetworkConnected(Ref ref) {
  return ref.watch(networkInfoProvider).onConnectivityChanged;
}
