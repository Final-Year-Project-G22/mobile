import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../app/features/auth/application/auth_notifier.dart';
import '../config/app_config.dart';
import '../services/websocket_service.dart';

final _secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final wsTokenProvider = FutureProvider<String?>((ref) async {
  final storage = ref.watch(_secureStorageProvider);
  return storage.read(key: 'access_token');
});

final webSocketServiceProvider = Provider<WebSocketService>((ref) {
  return WebSocketService(
    tokenProvider: () => ref.read(wsTokenProvider.future),
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
  final authState = ref.watch(authProvider);
  final account = authState.asData?.value.account;

  if (account == null) return const Stream.empty();

  final wsUri = _buildWsUri();
  debugPrint('[WS] Starting connection to $wsUri');

  ref.onDispose(() {
    debugPrint('[WS] Service disposed');
  });

  unawaited(service.connect(wsUri));

  return service.messages;
});
