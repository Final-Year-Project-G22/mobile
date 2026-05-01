import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'constants/api_constants.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

class ApiClient {
  late final Dio dio;
  late final AuthInterceptor _authInterceptor;
  String? Function()? _getLocaleCode;

  ApiClient({
    required FlutterSecureStorage secureStorage,
    String? baseUrl,
    bool enableLogging = true,
    List<Interceptor>? additionalInterceptors,
    String? Function()? getLocaleCode,
  }) : _getLocaleCode = getLocaleCode {
    dio = _createDio(baseUrl: baseUrl ?? 'https://api.example.com/v1');
    _authInterceptor = AuthInterceptor(storage: secureStorage);
    _setupInterceptors(enableLogging, additionalInterceptors);
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
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final localeCode = _getLocaleCode?.call() ?? 'en';
          options.headers['Accept-Language'] = localeCode;
          handler.next(options);
        },
      ),
      ...?additional,
    ];
    dio.interceptors.addAll(interceptors);
  }

  AuthInterceptor get authInterceptor => _authInterceptor;

  String? get accessToken => _authInterceptor.accessToken;
  String? get refreshToken => _authInterceptor.refreshToken;
  DateTime? get expiresAt => _authInterceptor.expiresAt;
  bool get isAuthenticated => _authInterceptor.isAuthenticated;

  // Callback setters (wired after construction)
  void setOnUnauthorizedCallback(void Function()? callback) {
    _authInterceptor.setOnUnauthorizedCallback(callback);
  }

  void setOnTokenRefreshedCallback(void Function(TokenPair)? callback) {
    _authInterceptor.setOnTokenRefreshedCallback(callback);
  }

  // Load tokens from secure storage (optional — tokens auto-load on first request)
  Future<void> loadTokensFromStorage() async {
    await _authInterceptor.loadTokensFromStorage();
  }

  // Token management (sets in-memory AND persists to secure storage)
  Future<void> setTokens(
    String accessToken,
    String? refreshToken, {
    DateTime? expiresAt,
  }) async {
    await _authInterceptor.setTokens(
      accessToken,
      refreshToken,
      expiresAt: expiresAt,
    );
  }

  Future<void> clearTokens() async {
    await _authInterceptor.clearTokens();
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
}
