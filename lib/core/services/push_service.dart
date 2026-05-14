import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../di/infra_providers.dart';

part 'push_service.g.dart';

class PushService {
  PushService(this._messaging);

  final FirebaseMessaging _messaging;

  Future<String?> getToken() => _messaging.getToken();

  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;

  Stream<RemoteMessage> get onMessage =>
      FirebaseMessaging.onMessage;

  Future<NotificationSettings> requestPermission() =>
      _messaging.requestPermission();

  Future<RemoteMessage?> getInitialMessage() =>
      _messaging.getInitialMessage();
}

@riverpod
PushService pushService(Ref ref) {
  return PushService(FirebaseMessaging.instance);
}

@Riverpod(keepAlive: true)
Future<void> pushRegistration(Ref ref) async {
  final service = ref.watch(pushServiceProvider);

  final settings = await service.requestPermission();
  debugPrint(
    '[Push] Authorization: ${settings.authorizationStatus}',
  );

  final token = await service.getToken();
  debugPrint('[Push] FCM token: $token');

  Future<void> register(String? t) async {
    if (t == null) return;
    try {
      final apiClient = ref.read(apiClientProvider);
      final client = NotificationsClient(apiClient.dio);
      await client.registerDevice(
        body: RegisterDeviceRequest(
          deviceType: 'android',
          deviceToken: t,
          pushToken: t,
        ),
      );
      debugPrint('[Push] Device registered');
    } on Exception catch (e) {
      debugPrint('[Push] Registration failed: $e');
    }
  }

  await register(token);

  service.onTokenRefresh.listen((t) => unawaited(register(t)));
}
