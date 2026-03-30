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
}

typedef ShouldSkipAuth = bool Function(String path);
typedef OnUnauthorized = void Function();
typedef OnTokenRefreshed = void Function(TokenPair tokens);

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
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _expiresAt = expiresAt;
    _needsTokenLoad = false;
    await _storage.write(key: _accessTokenKey, value: accessToken);
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
    }
    if (expiresAt != null) {
      await _storage.write(
        key: _expiresAtKey,
        value: expiresAt.toIso8601String(),
      );
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
        final refreshed = await _refreshTokenAsync(err.requestOptions);
        if (refreshed) {
          _retryPendingRequests();
          err.requestOptions.headers['Authorization'] = 'Bearer $_accessToken';
          final response = await _dio.fetch(err.requestOptions);
          return handler.resolve(response);
        }
      } catch (e) {
        _clearPendingRequests();
        onUnauthorized?.call();
      } finally {
        _isRefreshing = false;
      }
    }

    handler.next(err);
  }

  Future<bool> _refreshTokenAsync(RequestOptions originalRequest) async {
    if (_refreshToken == null) return false;

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

        if (newAccessToken != null) {
          await setTokens(newAccessToken, newRefreshToken ?? _refreshToken);

          onTokenRefreshed?.call(
            TokenPair(
              accessToken: newAccessToken,
              refreshToken: newRefreshToken,
            ),
          );

          return true;
        }
      }
    } catch (e) {
      await clearTokens();
    }

    return false;
  }

  String? _extractRefreshTokenFromHeaders(Headers headers) {
    final setCookie = headers['set-cookie'];
    if (setCookie != null && setCookie.isNotEmpty) {
      for (final cookie in setCookie) {
        if (cookie.startsWith('refresh_token=')) {
          return cookie.split(';').first.split('=').last;
        }
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

  void _retryPendingRequests() {
    for (final request in _pendingRequests) {
      request.handler.resolve(
        Response(requestOptions: request.options, statusCode: 200),
      );
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
