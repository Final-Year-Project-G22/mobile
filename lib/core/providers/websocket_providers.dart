import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import '../services/websocket_service.dart';

part 'websocket_providers.g.dart';

@Riverpod(keepAlive: true)
FlutterSecureStorage wsSecureStorage(Ref ref) {
  return const FlutterSecureStorage();
}

@Riverpod(keepAlive: true)
WebSocketService webSocketService(Ref ref) {
  final storage = ref.watch(wsSecureStorageProvider);
  return WebSocketService(
    tokenProvider: () => storage.read(key: 'access_token'),
  );
}

Uri _buildWsUri() {
  final baseUrl = AppConfig.apiBaseUrl;
  final uri = Uri.parse(baseUrl);
  final wsScheme = uri.scheme == 'https' ? 'wss' : 'ws';
  return uri.replace(scheme: wsScheme, path: '/ws');
}

@Riverpod(keepAlive: true)
Stream<Map<String, dynamic>> wsMessages(Ref ref) {
  final service = ref.watch(webSocketServiceProvider);
  final wsUri = _buildWsUri();

  ref.onDispose(() {
    if (kDebugMode) debugPrint('[WS] StreamProvider disposed');
  });

  unawaited(service.connect(wsUri));
  return service.messages;
}
