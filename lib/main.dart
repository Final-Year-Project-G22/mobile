import 'package:device_preview/device_preview.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/features/notifications/application/push_handler.dart';
import 'core/config/app_config.dart';

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  await onBackgroundPush(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final envFile = AppConfig.isProduction
      ? 'assets/.env.production'
      : AppConfig.isDevelopment
      ? 'assets/.env.development'
      : 'assets/.env';
  await dotenv.load(fileName: envFile);

  // FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

  // await Firebase.initializeApp();

  runApp(
    DevicePreview(
      builder: (context) => const ProviderScope(child: App()),
    ),
  );
}
