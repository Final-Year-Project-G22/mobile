import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/push_service.dart';
import '../../../router/app_router.dart';

part 'push_handler.g.dart';

@pragma('vm:entry-point')
Future<void> onBackgroundPush(RemoteMessage message) async {
  debugPrint('[Push] Background message: ${message.notification?.title}');
}

@riverpod
void pushMessageHandler(Ref ref) {
  final pushService = ref.watch(pushServiceProvider);

  pushService.onMessage.listen((message) {
    debugPrint('[Push] Foreground: ${message.notification?.title}');
  });
}

@Riverpod(keepAlive: true)
Future<void> pushTapHandler(Ref ref) async {
  final pushService = ref.watch(pushServiceProvider);

  // Handle tap from terminated state (app was killed)
  final initialMessage = await pushService.getInitialMessage();
  if (initialMessage != null) {
    debugPrint('[Push] Opened from terminated: ${initialMessage.notification?.title}');
    ref.read(routerProvider).go('/inbox');
  }

  // Handle tap from background state (app was in background)
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    debugPrint('[Push] Opened from background: ${message.notification?.title}');
    ref.read(routerProvider).go('/inbox');
  });
}
