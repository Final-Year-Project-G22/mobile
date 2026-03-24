import 'package:api_client/api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mobile/app/features/auth/domain/entities/auth_response.dart';
import 'package:mobile/app/features/auth/domain/failures/auth_user_failure.dart';
import 'package:mobile/app/features/auth/domain/i_auth_repository.dart';
import 'package:mobile/core/auth/token_storage.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthenticationClient _client;
  final ApiClient _apiClient;
  final TokenStorage _tokenStorage;

  const AuthRepositoryImpl(this._client, this._apiClient, this._tokenStorage);

  @override
  Future<Either<AuthUserFailure, AuthResponse>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final httpResponse = await _client.register(
        body: RegisterRequest(email: email, password: password, firstName: firstName, lastName: lastName),
      );
      await _tokenStorage.saveTokens(
        accessToken: httpResponse.data.accessToken,
        expiresAt: httpResponse.data.expiresAt,
      );
      _apiClient.setAccessToken(httpResponse.data.accessToken);
      return Right(
        AuthResponse(
          accessToken: httpResponse.data.accessToken,
          expiresAt: httpResponse.data.expiresAt,
          user: AuthUser(
            id: httpResponse.data.user.id,
            firstName: httpResponse.data.user.firstName,
            lastName: httpResponse.data.user.lastName,
          ),
          account: AuthAccount(
            id: httpResponse.data.account.id,
            email: httpResponse.data.account.email,
            status: httpResponse.data.account.status,
          ),
        ),
      );
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return const Left(AuthUserFailure.serverError());
    }
  }

  @override
  Future<Either<AuthUserFailure, Unit>> logout() async {
    try {
      await _client.logout();
      await _tokenStorage.clear();
      _apiClient.clearTokens();
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    }
  }

  @override
  Future<Either<AuthUserFailure, Unit>> logoutAll() async {
    try {
      await _client.logoutAll();
      await _tokenStorage.clear();
      _apiClient.clearTokens();
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    }
  }

  @override
  Future<Either<AuthUserFailure, AuthResponse>> login({required String email, required String password}) async {
    try {
      final httpResponse = await _client.login(
        body: LoginRequest(email: email, password: password),
      );

      // Extract refresh token from Set-Cookie header
      final refreshToken = _extractRefreshToken(httpResponse.response.headers);

      // Save tokens to secure storage
      await _tokenStorage.saveTokens(
        accessToken: httpResponse.data.accessToken,
        refreshToken: refreshToken,
        expiresAt: httpResponse.data.expiresAt,
      );

      // Set tokens in ApiClient (for subsequent requests)
      _apiClient.setTokens(httpResponse.data.accessToken, refreshToken);

      return Right(
        AuthResponse(
          accessToken: httpResponse.data.accessToken,
          expiresAt: httpResponse.data.expiresAt,
          user: AuthUser(
            id: httpResponse.data.user.id,
            firstName: httpResponse.data.user.firstName,
            lastName: httpResponse.data.user.lastName,
          ),
          account: AuthAccount(
            id: httpResponse.data.account.id,
            email: httpResponse.data.account.email,
            status: httpResponse.data.account.status,
          ),
        ),
      );
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return const Left(AuthUserFailure.serverError());
    }
  }

  AuthUserFailure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const AuthUserFailure.networkError();
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;
        final code = data is Map<String, dynamic> ? data['code'] : null;
        final detail = data is Map<String, dynamic> ? data['detail'] as String? : null;

        if (statusCode == 409 || code == 'conflict') {
          return AuthUserFailure.emailAlreadyInUse(message: detail);
        }
        if (statusCode == 401 || code == 'unauthorized') {
          return AuthUserFailure.invalidEmailAndPasswordCombination(message: detail);
        }
        return AuthUserFailure.serverError(message: detail);
      default:
        return const AuthUserFailure.serverError();
    }
  }

  String? _extractRefreshToken(Headers headers) {
    final setCookie = headers['set-cookie'];
    if (setCookie == null) return null;

    for (final cookie in setCookie) {
      if (cookie.startsWith('refresh_token=')) {
        return cookie.split(';').first.split('=').last;
      }
    }
    return null;
  }
}
