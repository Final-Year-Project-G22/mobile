import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/di/app_providers.dart';
import '../../../../core/di/auth_providers.dart';
import '../../../../core/di/infra_providers.dart';
import '../domain/entities/auth_response.dart';
import '../domain/entities/auth_status.dart';
import '../domain/entities/oauth_callback_result.dart';
import '../domain/entities/oauth_pending_email.dart';
import '../domain/failures/auth_user_failure.dart';
import '../domain/validator/auth_value_object_validator.dart';
import 'auth_oauth_state.dart';

part 'auth_notifier.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  static const _prefsAccessToken = 'access_token';
  static const _prefsRefreshToken = 'refresh_token';
  static const _prefsExpiresAt = 'expires_at';
  static const _prefsCachedUser = 'cached_user';
  static const _prefsCachedAccount = 'cached_account';

  @override
  Future<AuthStatus> build() async {
    final apiClient = ref.read(apiClientProvider)
      ..setOnUnauthorizedCallback(() async {
        await forceLogout();
      });

    try {
      // Load persisted tokens from secure storage
      await apiClient.loadTokensFromStorage();
    } on Exception catch (_) {
      // Storage failure — fall through to shared_preferences below
    }

    // Fallback: try shared_preferences if flutter_secure_storage has no tokens
    if (!apiClient.isAuthenticated) {
      final restored = await _restoreTokensFromPrefs();
      if (!restored) {
        return const Unauthenticated();
      }
    }

    // No token after restore/fallback.
    if (!apiClient.isAuthenticated) {
      return const Unauthenticated();
    }

    // If token is already expired (or nearly expired), attempt a silent refresh
    // before reporting an authenticated session.
    if (_isTokenExpiredOrNearExpiry(apiClient.expiresAt)) {
      final refreshed = await apiClient.refreshTokens();
      if (!refreshed) {
        await apiClient.clearTokens();
        await _clearPrefs();
        return const Unauthenticated();
      }
    }

    final repository = ref.read(authRepositoryProvider);
    final userResult = await repository.getCurrentUser();
    if (userResult.isRight()) {
      final authResponse = userResult.getOrElse(() => throw StateError('unreachable'));
      _clearOAuthTransientState();
      await _cacheAuthData(authResponse.user, authResponse.account);
      final status = Authenticated(
        user: authResponse.user,
        account: authResponse.account,
      );
      state = AsyncValue.data(status);
      return status;
    }

    final cachedUser = await _loadCachedUser();
    final cachedAccount = await _loadCachedAccount();
    if (cachedUser != null && cachedAccount != null) {
      return Authenticated(user: cachedUser, account: cachedAccount);
    }
    unawaited(forceLogout());
    return const Unauthenticated();
  }

  bool _isTokenExpiredOrNearExpiry(DateTime? expiresAt) {
    if (expiresAt == null) return true;
    final threshold = DateTime.now().add(const Duration(seconds: 30));
    return !expiresAt.isAfter(threshold);
  }

  Future<bool> _restoreTokensFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString(_prefsAccessToken);
      final refreshToken = prefs.getString(_prefsRefreshToken);
      final expiresAtStr = prefs.getString(_prefsExpiresAt);
      if (accessToken == null) return false;

      final apiClient = ref.read(apiClientProvider);
      await apiClient.setTokens(
        accessToken,
        refreshToken,
        expiresAt: expiresAtStr != null ? DateTime.tryParse(expiresAtStr) : null,
      );
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<void> _saveTokensToPrefs() async {
    try {
      final apiClient = ref.read(apiClientProvider);
      if (apiClient.accessToken == null) return;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefsAccessToken, apiClient.accessToken!);
      if (apiClient.refreshToken != null) {
        await prefs.setString(_prefsRefreshToken, apiClient.refreshToken!);
      } else {
        await prefs.remove(_prefsRefreshToken);
      }
      if (apiClient.expiresAt != null) {
        await prefs.setString(
          _prefsExpiresAt,
          apiClient.expiresAt!.toIso8601String(),
        );
      } else {
        await prefs.remove(_prefsExpiresAt);
      }
    } on Exception catch (_) {
      // Non-critical — tokens are already stored in flutter_secure_storage
    }
  }

  Future<void> _clearPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_prefsAccessToken);
      await prefs.remove(_prefsRefreshToken);
      await prefs.remove(_prefsExpiresAt);
    } on Exception catch (e) {
      if (kDebugMode) debugPrint('[Auth] Failed to clear prefs: $e');
    }
  }

  Future<void> _cacheAuthData(AuthUser user, AuthAccount account) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _prefsCachedUser,
        jsonEncode({
          'id': user.id,
          'firstName': user.firstName,
          'lastName': user.lastName,
        }),
      );
      await prefs.setString(
        _prefsCachedAccount,
        jsonEncode({
          'id': account.id,
          'email': account.email,
          'status': account.status,
          'language': account.language,
        }),
      );
    } on Exception catch (_) {}
  }

  Future<AuthUser?> _loadCachedUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_prefsCachedUser);
      if (json == null) return null;
      final map = jsonDecode(json) as Map<String, dynamic>;
      return AuthUser(
        id: map['id'] as String,
        firstName: map['firstName'] as String,
        lastName: map['lastName'] as String,
      );
    } on Exception catch (_) {
      return null;
    }
  }

  Future<AuthAccount?> _loadCachedAccount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_prefsCachedAccount);
      if (json == null) return null;
      final map = jsonDecode(json) as Map<String, dynamic>;
      return AuthAccount(
        id: map['id'] as String,
        email: map['email'] as String,
        status: map['status'] as String,
        language: map['language'] as String? ?? 'en',
      );
    } on Exception catch (_) {
      return null;
    }
  }

  Future<void> _clearCachedAuthData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_prefsCachedUser);
      await prefs.remove(_prefsCachedAccount);
    } on Exception catch (_) {}
  }

  Future<void> forceLogout() async {
    await _clearCachedAuthData();
    final apiClient = ref.read(apiClientProvider);
    await apiClient.clearTokens();
    await _clearPrefs();
    _clearOAuthTransientState();
    state = const AsyncValue.data(Unauthenticated());
  }

  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final repository = ref.read(authRepositoryProvider);

    final result = await repository.login(
      identifier: identifier,
      password: password,
    );
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      _applyAuthenticated,
    );
  }

  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? username,
  }) async {
    state = const AsyncValue.loading();
    final repository = ref.read(authRepositoryProvider);

    final result = await repository.register(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      username: username,
    );
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (authResponse) async {
        final accountStatus = authResponse.account.status.trim().toLowerCase();
        final isPendingVerification =
            accountStatus == 'pending_verification' ||
            accountStatus == 'pending-verification' ||
            accountStatus == 'pending verification' ||
            accountStatus == 'pending';

        if (isPendingVerification) {
          state = const AsyncValue.data(PendingVerification());
          return;
        }

        await _applyAuthenticated(authResponse);
      },
    );
  }

  Future<bool> changePassword({
    required String existingPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final repository = ref.read(authRepositoryProvider);
    final result = await repository.changePassword(
      existingPassword: existingPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
    return result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return false;
      },
      (_) => true,
    );
  }

  Future<void> completeVerification() async {
    final apiClient = ref.read(apiClientProvider);
    await apiClient.loadTokensFromStorage();
    final repository = ref.read(authRepositoryProvider);
    final userResult = await repository.getCurrentUser();
    await userResult.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
      _applyAuthenticated,
    );
  }

  Future<void> logout() async {
    await _clearCachedAuthData();
    state = const AsyncValue.loading();
    final repository = ref.read(authRepositoryProvider);
    final apiClient = ref.read(apiClientProvider);

    try {
      // Attempt backend logout, but don't let failure block local cleanup
      await repository.logout();
    } on Exception catch (_) {
      // Ignore backend errors — still clear local session
    }

    // Always clear local tokens and state
    await apiClient.clearTokens();
    await _clearPrefs();
    _clearOAuthTransientState();
    state = const AsyncValue.data(Unauthenticated());
  }

  Future<void> loadOAuthProviders() async {
    final oauthStateNotifier = ref.read(authOAuthStateProvider.notifier);
    oauthStateNotifier.state = oauthStateNotifier.state.copyWith(
      isLoadingOAuthProviders: true,
      oauthProvidersFailure: null,
    );

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.getOAuthProviders();

    result.fold(
      (failure) {
        oauthStateNotifier.state = oauthStateNotifier.state.copyWith(
          isLoadingOAuthProviders: false,
          oauthProvidersFailure: failure,
        );
      },
      (providers) {
        oauthStateNotifier.state = oauthStateNotifier.state.copyWith(
          oauthProviders: providers,
          isLoadingOAuthProviders: false,
          oauthProvidersFailure: null,
        );
      },
    );
  }

  Future<bool> startOAuthLogin(String provider) async {
    final oauthStateNotifier = ref.read(authOAuthStateProvider.notifier);
    oauthStateNotifier.state = oauthStateNotifier.state.copyWith(
      oauthInProgress: true,
      oauthProvidersFailure: null,
      pendingOAuthEmail: null,
    );

    try {
      final initiateUrl = AppConfig.buildOAuthLoginUri(provider);
      final callbackUrlScheme = AppConfig.oauthCallbackScheme;

      final result = await FlutterWebAuth2.authenticate(
        url: initiateUrl.toString(),
        callbackUrlScheme: callbackUrlScheme,
        options: const FlutterWebAuth2Options(
          preferEphemeral: true,
          intentFlags: ephemeralIntentFlags,
        ),
      );

      final callbackUri = Uri.parse(result);
      final ok = await _processOAuthCallback(callbackUri);

      oauthStateNotifier.state = oauthStateNotifier.state.copyWith(
        oauthInProgress: false,
      );
      return ok;
    } on Exception catch (e) {
      if (e.toString().contains('cancelled') || e.toString().contains('canceled')) {
        _setOAuthFailure(
          const AuthUserFailure.oauthCancelled(
            message: 'OAuth sign in was cancelled',
          ),
        );
      } else {
        _setOAuthFailure(
          AuthUserFailure.oauthProviderUnavailable(
            message: e.toString(),
          ),
        );
      }
      return false;
    }
  }

  Future<bool> _processOAuthCallback(Uri uri) async {
    final accessToken = uri.queryParameters['access_token'];
    final refreshToken = uri.queryParameters['refresh_token'];
    final expiresAt = uri.queryParameters['expires_at'];
    final error = uri.queryParameters['error'];
    final emailRequired = uri.queryParameters['email_required'] == 'true';

    if (error != null && error.isNotEmpty) {
      final message =
          uri.queryParameters['error_description'] ?? uri.queryParameters['message'] ?? 'OAuth login failed';
      _setOAuthFailure(AuthUserFailure.oauthCallbackInvalid(message: message));
      return false;
    }

    if (emailRequired) {
      final provider = uri.queryParameters['provider'] ?? '';
      final stateValue = uri.queryParameters['state'] ?? '';
      final oauthStateNotifier = ref.read(authOAuthStateProvider.notifier);
      oauthStateNotifier.state = oauthStateNotifier.state.copyWith(
        oauthInProgress: false,
        pendingOAuthEmail: OAuthPendingEmail(
          firstName: '',
          lastName: '',
          name: '',
          provider: provider,
          state: stateValue,
          subject: '',
        ),
      );
      return false;
    }

    if (accessToken != null && accessToken.isNotEmpty) {
      await completeOAuthFromDeepLink(
        accessToken: accessToken,
        refreshToken: refreshToken ?? '',
        expiresAt: expiresAt ?? '',
      );
      await Future<void>.delayed(const Duration(milliseconds: 120));
      return state.value?.isAuthenticated ?? false;
    } else {
      _setOAuthFailure(
        const AuthUserFailure.serverError(
          message: 'No access token received from OAuth provider',
        ),
      );
      return false;
    }
  }

  Future<void> handleOAuthDeepLink(Uri uri) async {
    final provider = _extractProviderFromCallback(uri);
    final code = uri.queryParameters['code'];
    final stateParam = uri.queryParameters['state'];
    final error = uri.queryParameters['error'];

    if (error != null && error.trim().isNotEmpty) {
      final message =
          uri.queryParameters['error_description'] ?? uri.queryParameters['message'] ?? 'OAuth login failed';
      _setOAuthFailure(AuthUserFailure.oauthCallbackInvalid(message: message));
      state = AsyncValue.error(
        AuthUserFailure.oauthCallbackInvalid(message: message),
        StackTrace.current,
      );
      return;
    }

    final oauthStateNotifier = ref.read(authOAuthStateProvider.notifier);
    oauthStateNotifier.state = oauthStateNotifier.state.copyWith(
      oauthInProgress: true,
      oauthProvidersFailure: null,
    );

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.handleOAuthCallback(
      provider: provider,
      code: code,
      state: stateParam,
    );

    await _handleOAuthCallbackResult(result);
  }

  Future<void> completeOAuthFromDeepLink({
    required String accessToken,
    required String refreshToken,
    required String expiresAt,
    bool isNewUser = false,
  }) async {
    final apiClient = ref.read(apiClientProvider);
    final parsedExpiresAt = DateTime.tryParse(expiresAt);
    if (parsedExpiresAt == null) {
      _setOAuthFailure(
        const AuthUserFailure.serverError(
          message: 'Invalid expiresAt format in OAuth redirect',
        ),
      );
      return;
    }

    await apiClient.setTokens(
      accessToken,
      refreshToken.isEmpty ? null : refreshToken,
      expiresAt: parsedExpiresAt,
    );

    final repository = ref.read(authRepositoryProvider);
    final userResult = await repository.getCurrentUser();
    await userResult.fold(
      (_) {
        _setOAuthFailure(
          const AuthUserFailure.serverError(
            message: 'Unable to fetch user profile after OAuth login',
          ),
        );
      },
      _applyAuthenticated,
    );
  }

  Future<void> completeOAuthEmail({
    required String email,
    required String state,
  }) async {
    final emailResult = validateEmail(email.trim());
    if (emailResult.isLeft()) {
      _setOAuthFailure(
        const AuthUserFailure.oauthCallbackInvalid(
          message: 'Please enter a valid email address',
        ),
      );
      return;
    }

    final oauthStateNotifier = ref.read(authOAuthStateProvider.notifier);
    oauthStateNotifier.state = oauthStateNotifier.state.copyWith(
      oauthInProgress: true,
      oauthProvidersFailure: null,
    );

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.completeOAuthWithEmail(
      email: email.trim(),
      state: state,
    );

    await _handleOAuthCallbackResult(result);
  }

  Future<void> _handleOAuthCallbackResult(
    Either<AuthUserFailure, OAuthCallbackResult> result,
  ) async {
    await result.fold(
      (failure) {
        _setOAuthFailure(failure);
        state = AsyncValue.error(failure, StackTrace.current);
      },
      (callbackResult) async {
        if (callbackResult.isAuthenticated && callbackResult.authResponse != null) {
          await _applyAuthenticated(callbackResult.authResponse!);
          return;
        }

        if (callbackResult.isEmailRequired && callbackResult.pendingEmail != null) {
          final oauthStateNotifier = ref.read(authOAuthStateProvider.notifier);
          oauthStateNotifier.state = oauthStateNotifier.state.copyWith(
            oauthInProgress: false,
            pendingOAuthEmail: callbackResult.pendingEmail,
          );
          state = const AsyncValue.data(Unauthenticated());
          return;
        }

        _setOAuthFailure(
          const AuthUserFailure.serverError(
            message: 'Invalid OAuth callback response',
          ),
        );
        state = AsyncValue.error(
          const AuthUserFailure.serverError(
            message: 'Invalid OAuth callback response',
          ),
          StackTrace.current,
        );
      },
    );
  }

  String _extractProviderFromCallback(Uri uri) {
    final providerQuery = uri.queryParameters['provider'];
    if (providerQuery != null && providerQuery.trim().isNotEmpty) {
      return providerQuery.trim();
    }

    if (uri.pathSegments.isNotEmpty) {
      final lastSegment = uri.pathSegments.last.trim();
      if (lastSegment.isNotEmpty) {
        return lastSegment;
      }
    }

    return '';
  }

  Future<void> _applyAuthenticated(AuthResponse authResponse) async {
    _clearOAuthTransientState();
    await _cacheAuthData(authResponse.user, authResponse.account);
    state = AsyncValue.data(
      Authenticated(
        user: authResponse.user,
        account: authResponse.account,
      ),
    );
    await _saveTokensToPrefs();

    // Sync language from backend response to local preference
    final language = authResponse.account.language;
    if (language.isNotEmpty) {
      ref.read(localeProvider.notifier).setLocale(
        Locale(language),
        syncToBackend: false,
      );
    }
  }

  void _setOAuthFailure(AuthUserFailure failure) {
    final oauthStateNotifier = ref.read(authOAuthStateProvider.notifier);
    oauthStateNotifier.state = oauthStateNotifier.state.copyWith(
      oauthInProgress: false,
      oauthProvidersFailure: failure,
    );
  }

  void _clearOAuthTransientState() {
    final oauthStateNotifier = ref.read(authOAuthStateProvider.notifier);
    oauthStateNotifier.state = oauthStateNotifier.state.copyWith(
      oauthInProgress: false,
      oauthProvidersFailure: null,
      pendingOAuthEmail: null,
    );
  }
}
