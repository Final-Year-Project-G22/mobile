import 'package:api_client/api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import '../network/app_network_info.dart';

part 'infra_providers.g.dart';

@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage();
}

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  final storage = ref.read(secureStorageProvider);

  return ApiClient(
    secureStorage: storage,
    baseUrl: AppConfig.apiBaseUrl,
    enableLogging: AppConfig.enableLogging,
  );
}

@riverpod
AppNetworkInfo networkInfo(Ref ref) {
  return AppNetworkInfo();
}

@riverpod
Stream<bool> isNetworkConnected(Ref ref) {
  return ref.watch(networkInfoProvider).onConnectivityChanged;
}
