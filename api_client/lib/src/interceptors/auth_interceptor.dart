import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenPair {
  final String accessToken;
  final String? refreshToken;
  final DateTime? expiresAt;

  const TokenPair({
    required this.accessToken,
    this.refreshToken,
    this.expiresAt,
  });

  factory TokenPair.fromJson(Map<String, dynamic> json) {
    return TokenPair(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String?,
      expiresAt: json['expiresAt'] != null
          ? DateTime.tryParse(json['expiresAt'] as String)
          : null,
    );
  }
}

typedef ShouldSkipAuth = bool Function(String path);
typedef OnUnauthorized = FutureOr<void> Function();
typedef OnTokenRefreshed = FutureOr<void> Function(TokenPair tokens);

class AuthInterceptor extends Interceptor {
  String? _accessToken;
  String? _refreshToken;
  DateTime? _expiresAt;
  bool _needsTokenLoad = true;

  final ShouldSkipAuth shouldSkipAuth;
  OnUnauthorized? onUnauthorized;
  OnTokenRefreshed? onTokenRefreshed;

  final Dio _dio;
  final FlutterSecureStorage _storage;
  bool _isRefreshing = false;
  final List<_QueuedRequest> _pendingRequests = [];

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _expiresAtKey = 'expires_at';

  AuthInterceptor({
    required FlutterSecureStorage storage,
    this.shouldSkipAuth = _defaultShouldSkipAuth,
    Dio? dio,
  }) : _storage = storage,
       _dio = dio ?? Dio();

  void setOnUnauthorizedCallback(OnUnauthorized? callback) {
    onUnauthorized = callback;
  }

  void setOnTokenRefreshedCallback(OnTokenRefreshed? callback) {
    onTokenRefreshed = callback;
  }

  static bool _defaultShouldSkipAuth(String path) {
    return path.contains('/auth/login') ||
        path.contains('/auth/register') ||
        path.contains('/auth/refresh');
  }

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  DateTime? get expiresAt => _expiresAt;
  bool get isAuthenticated => _accessToken != null;

  Future<void> loadTokensFromStorage() async {
    await _ensureTokensLoaded();
  }

  Future<void> _ensureTokensLoaded() async {
    if (!_needsTokenLoad) return;
    _needsTokenLoad = false;

    _accessToken = await _storage.read(key: _accessTokenKey);
    _refreshToken = await _storage.read(key: _refreshTokenKey);

    final expiresAtRaw = await _storage.read(key: _expiresAtKey);
    if (expiresAtRaw != null) {
      _expiresAt = DateTime.tryParse(expiresAtRaw);
    }
  }

  Future<void> setTokens(
    String accessToken,
    String? refreshToken, {
    DateTime? expiresAt,
  }) async {
    final normalizedRefreshToken =
        (refreshToken != null && refreshToken.isNotEmpty) ? refreshToken : null;

    _accessToken = accessToken;
    _refreshToken = normalizedRefreshToken;
    _expiresAt = expiresAt;
    _needsTokenLoad = false;

    await _storage.write(key: _accessTokenKey, value: accessToken);

    if (normalizedRefreshToken != null) {
      await _storage.write(
        key: _refreshTokenKey,
        value: normalizedRefreshToken,
      );
    } else {
      await _storage.delete(key: _refreshTokenKey);
    }

    if (expiresAt != null) {
      await _storage.write(
        key: _expiresAtKey,
        value: expiresAt.toIso8601String(),
      );
    } else {
      await _storage.delete(key: _expiresAtKey);
    }
  }

  Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;
    _expiresAt = null;
    _needsTokenLoad = false;

    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _expiresAtKey);
  }

  Future<bool> refreshTokens() async {
    if (_isRefreshing) return false;
    _isRefreshing = true;
    try {
      return await _refreshTokenAsync();
    } finally {
      _isRefreshing = false;
    }
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (shouldSkipAuth(options.path)) {
      return handler.next(options);
    }

    await _ensureTokensLoaded();

    if (_accessToken != null) {
      options.headers['Authorization'] = 'Bearer $_accessToken';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        !shouldSkipAuth(err.requestOptions.path)) {
      if (_isRefreshing) {
        _addPendingRequest(err.requestOptions, handler);
        return;
      }

      _isRefreshing = true;

      try {
        final refreshed = await _refreshTokenAsync();
        if (refreshed) {
          _retryPendingRequests();
          err.requestOptions.headers['Authorization'] = 'Bearer $_accessToken';
          final response = await _dio.fetch(err.requestOptions);
          return handler.resolve(response);
        }

        // Refresh attempt finished but did not succeed.
        // Reject queued requests and notify app-level auth state.
        _clearPendingRequests();
        await onUnauthorized?.call();
      } catch (_) {
        _clearPendingRequests();
        await onUnauthorized?.call();
      } finally {
        _isRefreshing = false;
      }
    }

    handler.next(err);
  }

  Future<bool> _refreshTokenAsync() async {
    await _ensureTokensLoaded();
    if (_refreshToken == null || _refreshToken!.isEmpty) return false;

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/api/v1/auth/refresh',
        options: Options(headers: {'Cookie': 'refresh_token=$_refreshToken'}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final newAccessToken = response.data!['accessToken'] as String?;
        final newRefreshToken = _extractRefreshTokenFromHeaders(
          response.headers,
        );
        final expiresAtRaw = response.data!['expiresAt'];
        DateTime? newExpiresAt;
        if (expiresAtRaw is String) {
          newExpiresAt = DateTime.tryParse(expiresAtRaw);
        }

        if (newAccessToken != null && newAccessToken.isNotEmpty) {
          await setTokens(
            newAccessToken,
            newRefreshToken ?? _refreshToken,
            expiresAt: newExpiresAt,
          );
          onTokenRefreshed?.call(
            TokenPair(
              accessToken: newAccessToken,
              refreshToken: newRefreshToken ?? _refreshToken,
              expiresAt: newExpiresAt,
            ),
          );
          return true;
        }
      }
    } catch (_) {
      await clearTokens();
    }

    return false;
  }

  String? _extractRefreshTokenFromHeaders(Headers headers) {
    final setCookie = headers['set-cookie'];
    if (setCookie == null) {
      return null;
    }

    for (final cookie in setCookie) {
      final tokens = cookie.split(';');
      for (final token in tokens) {
        final trimmedToken = token.trim();
        if (!trimmedToken.startsWith('refresh_token=')) {
          continue;
        }

        final parts = trimmedToken.split('=');
        if (parts.length < 2) {
          continue;
        }

        return parts.sublist(1).join('=');
      }
    }

    return null;
  }

  void _addPendingRequest(
    RequestOptions options,
    ErrorInterceptorHandler handler,
  ) {
    _pendingRequests.add(_QueuedRequest(options, handler));
  }

  void _retryPendingRequests() async {
    for (final request in _pendingRequests) {
      try {
        final clonedOptions = request.options.copyWith(
          headers: {
            ...request.options.headers,
            'Authorization': 'Bearer $_accessToken',
          },
        );
        final response = await _dio.fetch(clonedOptions);
        request.handler.resolve(response);
      } catch (e) {
        request.handler.reject(
          DioException(
            requestOptions: request.options,
            error: e,
            type: DioExceptionType.unknown,
          ),
        );
      }
    }
    _pendingRequests.clear();
  }

  void _clearPendingRequests() {
    for (final request in _pendingRequests) {
      request.handler.reject(
        DioException(
          requestOptions: request.options,
          error: Exception('Token refresh failed'),
          type: DioExceptionType.unknown,
        ),
      );
    }
    _pendingRequests.clear();
  }
}

class _QueuedRequest {
  final RequestOptions options;
  final ErrorInterceptorHandler handler;

  _QueuedRequest(this.options, this.handler);
}
