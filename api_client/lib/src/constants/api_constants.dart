class ApiConstants {
  ApiConstants._();

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
  static const Duration sendTimeout = Duration(seconds: 15);

  static const String contentType = 'application/json';
  static const String accept = 'application/json';

  static const String authTokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';

  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 1);

  static const String accessTokenKey = 'access_token';
  static const String refreshTokenCookieKey = 'refresh_token';
}
