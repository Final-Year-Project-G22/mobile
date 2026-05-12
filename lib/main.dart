import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/config/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final envFile = AppConfig.isProduction
      ? 'assets/.env.production'
      : AppConfig.isDevelopment
      ? 'assets/.env.development'
      : 'assets/.env';
  await dotenv.load(fileName: envFile);
  runApp(
    DevicePreview(
      builder: (context) => const ProviderScope(child: App()),
    ),
  );
}
