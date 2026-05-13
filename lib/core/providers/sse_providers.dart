import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import '../lifecycle/app_lifecycle_provider.dart';
import '../services/sse_service.dart';

part 'sse_providers.g.dart';

@Riverpod(keepAlive: true)
FlutterSecureStorage sseSecureStorage(Ref ref) {
  return const FlutterSecureStorage();
}

@Riverpod(keepAlive: true)
SseService sseService(Ref ref) {
  final storage = ref.watch(sseSecureStorageProvider);
  return SseService(
    tokenProvider: () => storage.read(key: 'access_token'),
  );
}

@Riverpod(keepAlive: true)
Uri sseInboxUri(Ref ref) {
  final base = Uri.parse(AppConfig.apiBaseUrl);
  return base.replace(path: '/api/v1/notifications/inbox/events');
}

@riverpod
Stream<Map<String, dynamic>> sseInboxEvents(Ref ref) {
  final isForeground = ref.watch(isAppInForegroundProvider);
  final uri = ref.watch(sseInboxUriProvider);
  final service = ref.watch(sseServiceProvider);

  if (!isForeground) {
    return const Stream.empty();
  }

  unawaited(service.connect(uri));

  ref.onDispose(service.disconnect);

  return service.events;
}
