import 'package:api_client/api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

import '../domain/entities/auth_response.dart';
import '../domain/entities/oauth_callback_result.dart';
import '../domain/entities/oauth_pending_email.dart';
import '../domain/entities/oauth_provider.dart';
import '../domain/failures/auth_user_failure.dart';
import '../domain/i_auth_repository.dart';

class AuthRepositoryImpl implements IAuthRepository {
  const AuthRepositoryImpl(this._client, this._oAuthClient, this._apiClient);

  final AuthenticationClient _client;
  final OAuthClient _oAuthClient;
  final ApiClient _apiClient;

  @override
  Future<Either<AuthUserFailure, AuthResponse>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? username,
  }) async {
    try {
      final httpResponse = await _client.register(
        body: RegisterRequest(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
          username: username,
        ),
      );

      await _apiClient.setTokens(
        httpResponse.data.accessToken,
        null,
        expiresAt: httpResponse.data.expiresAt,
      );

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
    } on Exception {
      return const Left(AuthUserFailure.serverError());
    }
  }

  @override
  Future<Either<AuthUserFailure, AuthResponse>> login({
    required String identifier,
    required String password,
  }) async {
    try {
      final httpResponse = await _client.login(
        body: LoginRequest(identifier: identifier, password: password),
      );

      final refreshToken = _extractRefreshToken(httpResponse.response.headers);

      await _apiClient.setTokens(
        httpResponse.data.accessToken,
        refreshToken,
        expiresAt: httpResponse.data.expiresAt,
      );

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
    } on Exception {
      return const Left(AuthUserFailure.serverError());
    }
  }

  @override
  Future<Either<AuthUserFailure, List<OAuthProvider>>> getOAuthProviders() async {
    try {
      final response = await _oAuthClient.getOAuthProviders();
      final rawProviders = response.data.providers;
      if (rawProviders == null) {
        return const Right([]);
      }

      final providers = <OAuthProvider>[];
      for (final rawProvider in rawProviders) {
        if (rawProvider is! Map<String, dynamic>) {
          continue;
        }

        try {
          final dto = OAuthProviderDto.fromJson(rawProvider);
          providers.add(_toOAuthProvider(dto));
        } on Exception {
          continue;
        }
      }

      return Right(providers);
    } on DioException catch (e) {
      return Left(_handleOAuthDioError(e));
    } on Exception {
      return const Left(AuthUserFailure.serverError());
    }
  }

  @override
  Future<Either<AuthUserFailure, OAuthCallbackResult>> handleOAuthCallback({
    required String provider,
    String? code,
    String? state,
  }) async {
    if (provider.trim().isEmpty) {
      return const Left(AuthUserFailure.unsupportedOAuthProvider());
    }
    if (code == null || code.trim().isEmpty || state == null || state.trim().isEmpty) {
      return const Left(
        AuthUserFailure.oauthCallbackInvalid(
          message: 'Missing callback code or state',
        ),
      );
    }

    try {
      final response = await _oAuthClient.oauthCallback(
        provider: provider,
        code: code,
        state: state,
      );
      return _handleOAuthCallbackResponse(response);
    } on DioException catch (e) {
      return Left(_handleOAuthDioError(e));
    } on Exception {
      return const Left(AuthUserFailure.serverError());
    }
  }

  @override
  Future<Either<AuthUserFailure, OAuthCallbackResult>> completeOAuthWithEmail({
    required String email,
    required String state,
  }) async {
    if (email.trim().isEmpty || state.trim().isEmpty) {
      return const Left(
        AuthUserFailure.oauthCallbackInvalid(
          message: 'Email and state are required',
        ),
      );
    }

    try {
      final response = await _oAuthClient.oauthCompleteWithEmail(
        body: OAuthCompleteEmailRequest(
          email: email,
          state: state,
        ),
      );
      return _handleOAuthCallbackResponse(response);
    } on DioException catch (e) {
      return Left(_handleOAuthDioError(e));
    } on Exception {
      return const Left(AuthUserFailure.serverError());
    }
  }

  @override
  Future<Either<AuthUserFailure, AuthResponse>> getCurrentUser() async {
    try {
      final httpResponse = await _client.getCurrentUser();
      return Right(
        AuthResponse(
          accessToken: '',
          expiresAt: DateTime.now(),
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
    } on Exception {
      return const Left(AuthUserFailure.serverError());
    }
  }

  @override
  Future<Either<AuthUserFailure, Unit>> logout() async {
    try {
      await _client.logout();
      await _apiClient.clearTokens();
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    }
  }

  @override
  Future<Either<AuthUserFailure, Unit>> logoutAll() async {
    try {
      await _client.logoutAll();
      await _apiClient.clearTokens();
      return const Right(unit);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    }
  }

  @override
  Future<Either<AuthUserFailure, String>> verifyOtp({
    required String otp,
  }) async {
    try {
      final httpResponse = await _client.verifyEmailOtp(
        body: VerifyEmailOtpRequest(otp: otp),
      );
      return Right(httpResponse.data.message);
    } on DioException catch (e) {
      return Left(_handleOtpDioError(e));
    } on Exception {
      return const Left(AuthUserFailure.serverError());
    }
  }

  @override
  Future<Either<AuthUserFailure, String>> resendOtp() async {
    try {
      final httpResponse = await _client.resendEmailOtp();
      return Right(httpResponse.data.message);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(AuthUserFailure.serverError());
    }
  }

  Future<Either<AuthUserFailure, OAuthCallbackResult>> _handleOAuthCallbackResponse(
    HttpResponse<OAuthCallbackResponse> response,
  ) async {
    final emailRequired = response.data.emailRequired;
    if (emailRequired != null) {
      return Right(
        OAuthCallbackResult.emailRequired(_toOAuthPendingEmail(emailRequired)),
      );
    }

    final accessToken = response.data.accessToken;
    final user = response.data.user;
    final account = response.data.account;
    final expiresAt = response.data.expiresAt;

    if (accessToken == null || user == null || account == null || expiresAt == null) {
      return const Left(
        AuthUserFailure.serverError(message: 'Invalid OAuth success payload'),
      );
    }

    final refreshToken = response.data.refreshToken ?? _extractRefreshToken(response.response.headers);
    await _apiClient.setTokens(
      accessToken,
      refreshToken,
      expiresAt: expiresAt,
    );

    return Right(
      OAuthCallbackResult.authenticated(
        AuthResponse(
          accessToken: accessToken,
          refreshToken: refreshToken,
          expiresAt: expiresAt,
          user: AuthUser(
            id: user.id,
            firstName: user.firstName,
            lastName: user.lastName,
          ),
          account: AuthAccount(
            id: account.id,
            email: account.email,
            status: account.status,
          ),
        ),
      ),
    );
  }

  OAuthProvider _toOAuthProvider(OAuthProviderDto dto) {
    return OAuthProvider(
      name: dto.name,
      displayName: dto.displayName,
      icon: dto.icon,
    );
  }

  OAuthPendingEmail _toOAuthPendingEmail(
    OAuthEmailRequiredResponse emailRequired,
  ) {
    return OAuthPendingEmail(
      firstName: emailRequired.firstName,
      lastName: emailRequired.lastName,
      name: emailRequired.name,
      provider: emailRequired.provider,
      state: emailRequired.state,
      subject: emailRequired.subject,
      pictureUrl: emailRequired.pictureUrl,
    );
  }

  AuthUserFailure _handleOtpDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const AuthUserFailure.networkError();
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;
        final detail = data is Map<String, dynamic> ? data['detail'] as String? : null;

        if (statusCode == 401) {
          return AuthUserFailure.invalidOtp(message: detail);
        }
        return AuthUserFailure.serverError(message: detail);
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return const AuthUserFailure.serverError();
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
          return AuthUserFailure.invalidEmailAndPasswordCombination(
            message: detail,
          );
        }
        return AuthUserFailure.serverError(message: detail);
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return const AuthUserFailure.serverError();
    }
  }

  AuthUserFailure _handleOAuthDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const AuthUserFailure.networkError();
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;
        final code = data is Map<String, dynamic> ? data['code'] as String? : null;
        final detail = data is Map<String, dynamic> ? data['detail'] as String? : null;

        if (code == 'oauth_cancelled') {
          return AuthUserFailure.oauthCancelled(message: detail);
        }

        if (statusCode == 404 || code == 'unsupported_oauth_provider') {
          return AuthUserFailure.unsupportedOAuthProvider(message: detail);
        }

        if (statusCode == 401 || code == 'oauth_state_invalid' || code == 'oauth_state_expired') {
          return AuthUserFailure.oauthStateInvalidOrExpired(message: detail);
        }

        if (statusCode == 422 || code == 'oauth_callback_invalid' || code == 'validation_error') {
          return AuthUserFailure.oauthCallbackInvalid(message: detail);
        }

        if (statusCode == 503 || code == 'oauth_provider_unavailable') {
          return AuthUserFailure.oauthProviderUnavailable(message: detail);
        }

        return AuthUserFailure.serverError(message: detail);
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return const AuthUserFailure.serverError();
    }
  }

  String? _extractRefreshToken(Headers headers) {
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
}
