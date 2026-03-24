import 'package:dio/dio.dart';

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
typedef OnUnauthorized = void Function();
typedef OnTokenRefreshed = void Function(TokenPair tokens);

class AuthInterceptor extends Interceptor {
  String? _accessToken;
  String? _refreshToken;
  final ShouldSkipAuth shouldSkipAuth;
  OnUnauthorized? onUnauthorized;
  OnTokenRefreshed? onTokenRefreshed;
  final Dio _dio;
  bool _isRefreshing = false;
  final List<_QueuedRequest> _pendingRequests = [];

  AuthInterceptor({this.shouldSkipAuth = _defaultShouldSkipAuth, Dio? dio})
    : _dio = dio ?? Dio();

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
  bool get isAuthenticated => _accessToken != null;

  void setAccessToken(String? token) {
    _accessToken = token;
  }

  void setRefreshToken(String? token) {
    _refreshToken = token;
  }

  void setTokens(String accessToken, String? refreshToken) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  void clearTokens() {
    _accessToken = null;
    _refreshToken = null;
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (shouldSkipAuth(options.path)) {
      return handler.next(options);
    }

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
    if (_refreshToken == null) {
      return false;
    }

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/auth/refresh',
        options: Options(headers: {'Cookie': 'refresh_token=$_refreshToken'}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final newAccessToken = response.data!['accessToken'] as String?;

        final newRefreshToken = _extractRefreshTokenFromHeaders(
          response.headers,
        );

        if (newAccessToken != null) {
          _accessToken = newAccessToken;
          if (newRefreshToken != null) {
            _refreshToken = newRefreshToken;
          }

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
      clearTokens();
    }

    return false;
  }

  String? _extractRefreshTokenFromHeaders(Headers headers) {
    final setCookie = headers['set-cookie'];
    if (setCookie != null && setCookie.isNotEmpty) {
      for (final cookie in setCookie) {
        if (cookie.startsWith('refresh_token=')) {
          final value = cookie.split(';').first.split('=').last;
          return value;
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
