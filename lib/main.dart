import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/core/config/app_config.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final envFile = AppConfig.isProduction
      ? 'assets/.env.production'
      : AppConfig.isDevelopment
      ? 'assets/.env.development'
      : 'assets/.env';
  await dotenv.load(fileName: envFile);
  runApp(const ProviderScope(child: App()));
}
