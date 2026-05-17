import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../config/app_config.dart';
import '../services/websocket_service.dart';

final _secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final webSocketServiceProvider = Provider<WebSocketService>((ref) {
  return WebSocketService(
    tokenProvider: () async {
      final storage = ref.read(_secureStorageProvider);
      return storage.read(key: 'access_token');
    },
  );
});

Uri _buildWsUri() {
  final baseUrl = AppConfig.apiBaseUrl;
  final uri = Uri.parse(baseUrl);
  final wsScheme = uri.scheme == 'https' ? 'wss' : 'ws';
  return uri.replace(scheme: wsScheme, path: '/ws');
}

final wsMessagesProvider = StreamProvider<Map<String, dynamic>>((ref) {
  final service = ref.watch(webSocketServiceProvider);
  final wsUri = _buildWsUri();

  ref.onDispose(() {
    if (kDebugMode) debugPrint('[WS] StreamProvider disposed');
  });

  unawaited(service.connect(wsUri));
  return service.messages;
});
