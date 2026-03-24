import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/core/config/app_constants.dart';
import 'package:mobile/core/config/environments.dart';

class AppConfig {
  AppConfig._();

  static const _envString = String.fromEnvironment('ENV', defaultValue: 'local');

  // Environment
  static Environments get environment => Environments.fromString(_envString);
  static bool get isDevelopment => environment == Environments.development;
  static bool get isProduction => environment == Environments.production;
  static bool get isLocal => environment == Environments.local;

  // Platform
  static bool get isWeb => kIsWeb;
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;
  static bool get isIOS => !kIsWeb && Platform.isIOS;

  // API URL
  static String get apiBaseUrl {
    final baseUrl = dotenv.env['API_BASE_URL'];
    if (baseUrl == null) {
      throw Exception('API_BASE_URL not set in environment variables');
    }

    if (isAndroid && baseUrl.contains('localhost')) {
      return baseUrl.replaceFirst('localhost', '10.0.2.2');
    }

    return baseUrl;
  }

  // App Info
  static const appName = AppConstants.appName;
  static const appVersion = AppConstants.appVersion;
  static bool get enableLogging => isDevelopment || isLocal;

  // Timeouts
  static const connectTimeout = Duration(seconds: 15);
  static const receiveTimeout = Duration(seconds: 15);
  static const sendTimeout = Duration(seconds: 15);
}
