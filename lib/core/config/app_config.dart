import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app_constants.dart';
import 'environments.dart';

class AppConfig {
  AppConfig._();

  static const _envString = String.fromEnvironment(
    'ENV',
    defaultValue: 'local',
  );

  // Environment
  static Environments get environment => Environments.fromString(_envString);
  static bool get isDevelopment => environment == Environments.development;
  static bool get isProduction => environment == Environments.production;
  static bool get isLocal => environment == Environments.local;

  // Platform
  static bool get isWeb => kIsWeb;
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;
  static bool get isIOS => !kIsWeb && Platform.isIOS;

  static String _requireEnv(String key) {
    final value = dotenv.env[key]?.trim();
    if (value == null || value.isEmpty) {
      throw Exception('$key not set in environment variables');
    }
    return value;
  }

  // API URL
  static String get apiBaseUrl {
    final baseUrl = _requireEnv('API_BASE_URL');

    if (isAndroid && baseUrl.contains('localhost')) {
      return baseUrl.replaceFirst('localhost', '10.0.2.2');
    }

    return baseUrl;
  }

  static String get oauthCallbackScheme => _requireEnv('OAUTH_CALLBACK_SCHEME').toLowerCase();

  static String get oauthCallbackHost => _requireEnv('OAUTH_CALLBACK_HOST');

  static String get oauthCallbackPath {
    final path = _requireEnv('OAUTH_CALLBACK_PATH');
    return path.startsWith('/') ? path : '/$path';
  }

  static Uri get oauthCallbackUri {
    final normalizedPath = oauthCallbackPath.startsWith('/') ? oauthCallbackPath.substring(1) : oauthCallbackPath;
    return Uri(
      scheme: oauthCallbackScheme,
      host: oauthCallbackHost,
      path: normalizedPath,
    );
  }

  static Uri buildOAuthLoginUri(String provider) {
    final base = Uri.parse(apiBaseUrl);
    return base.resolve('/api/v1/auth/oauth/login/$provider');
  }

  // App Info
  static const String appName = AppConstants.appName;
  static const String appVersion = AppConstants.appVersion;
  static bool get enableLogging => isDevelopment || isLocal;

  // Timeouts
  static const connectTimeout = Duration(seconds: 15);
  static const receiveTimeout = Duration(seconds: 15);
  static const sendTimeout = Duration(seconds: 15);
}
