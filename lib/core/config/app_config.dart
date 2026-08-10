import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app_constants.dart';
import 'environments.dart';
import 'file_url_rewriter.dart';

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
  static String get _rawApiBaseUrl => _requireEnv('API_BASE_URL');

  /// True when the app is pointed at a local backend on a platform where
  /// `localhost` is not the host machine (Android emulator).
  static bool get _rewriteLocalhostForPlatform => shouldRewriteLocalhost(
    isAndroid: isAndroid,
    rawApiBaseUrl: _rawApiBaseUrl,
  );

  static String get apiBaseUrl {
    final baseUrl = _rawApiBaseUrl;

    if (_rewriteLocalhostForPlatform) {
      return baseUrl.replaceFirst('localhost', '10.0.2.2');
    }

    return baseUrl;
  }

  /// Rewrites a backend-returned file URL (attachment, avatar, thumbnail,
  /// presigned preview/download link) so it resolves from this platform when
  /// the app is pointed at a local backend.
  ///
  /// Mirrors [apiBaseUrl]: when the API base host is rewritten for this
  /// platform (Android emulator, `localhost` -> `10.0.2.2`), localhost file
  /// URLs are rewritten the same way; every other URL is returned unchanged.
  static String rewriteFileUrl(String url) => rewriteFileUrlHost(
    url,
    shouldRewriteLocalhost: _rewriteLocalhostForPlatform,
  );

  static String get oauthCallbackScheme =>
      _requireEnv('OAUTH_CALLBACK_SCHEME').toLowerCase();

  static String get oauthCallbackHost => _requireEnv('OAUTH_CALLBACK_HOST');

  static String get oauthCallbackPath {
    final path = _requireEnv('OAUTH_CALLBACK_PATH');
    return path.startsWith('/') ? path : '/$path';
  }

  static Uri get oauthCallbackUri {
    final normalizedPath = oauthCallbackPath.startsWith('/')
        ? oauthCallbackPath.substring(1)
        : oauthCallbackPath;
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
