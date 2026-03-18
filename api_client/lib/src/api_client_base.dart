import 'package:dio/dio.dart';

import 'constants/api_constants.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

class ApiClient {
  static ApiClient? _instance;
  late final Dio dio;
  late final AuthInterceptor _authInterceptor;

  ApiClient._({
    String? baseUrl,
    bool enableLogging = true,
    List<Interceptor>? additionalInterceptors,
    void Function()? onUnauthorized,
    void Function(TokenPair)? onTokenRefreshed,
  }) {
    dio = _createDio(baseUrl: baseUrl ?? 'https://api.example.com/v1');
    _authInterceptor = AuthInterceptor(
      onUnauthorized: onUnauthorized,
      onTokenRefreshed: onTokenRefreshed,
    );
    _setupInterceptors(enableLogging, additionalInterceptors);
  }

  factory ApiClient({
    String? baseUrl,
    bool enableLogging = true,
    List<Interceptor>? additionalInterceptors,
    void Function()? onUnauthorized,
    void Function(TokenPair)? onTokenRefreshed,
  }) {
    _instance ??= ApiClient._(
      baseUrl: baseUrl,
      enableLogging: enableLogging,
      additionalInterceptors: additionalInterceptors,
      onUnauthorized: onUnauthorized,
      onTokenRefreshed: onTokenRefreshed,
    );
    return _instance!;
  }

  Dio _createDio({required String baseUrl}) {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        sendTimeout: ApiConstants.sendTimeout,
        headers: {
          'Content-Type': ApiConstants.contentType,
          'Accept': ApiConstants.accept,
        },
        validateStatus: (status) => status != null && status < 400,
      ),
    );
  }

  void _setupInterceptors(bool enableLogging, List<Interceptor>? additional) {
    final interceptors = [
      _authInterceptor,
      ErrorInterceptor(),
      if (enableLogging) LoggingInterceptor(),
      ...?additional,
    ];
    dio.interceptors.addAll(interceptors);
  }

  AuthInterceptor get authInterceptor => _authInterceptor;

  String? get accessToken => _authInterceptor.accessToken;
  String? get refreshToken => _authInterceptor.refreshToken;
  bool get isAuthenticated => _authInterceptor.isAuthenticated;

  void setAccessToken(String token) {
    _authInterceptor.setAccessToken(token);
  }

  void setRefreshToken(String token) {
    _authInterceptor.setRefreshToken(token);
  }

  void setTokens(String accessToken, String? refreshToken) {
    _authInterceptor.setTokens(accessToken, refreshToken);
  }

  void clearTokens() {
    _authInterceptor.clearTokens();
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  void updateBaseUrl(String baseUrl) {
    dio.options.baseUrl = baseUrl;
  }

  static void reset() {
    _instance = null;
  }
}
