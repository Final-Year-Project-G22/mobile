import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/di/auth_providers.dart';
import '../../../../core/di/infra_providers.dart';
import '../domain/entities/auth_response.dart';
import '../domain/entities/auth_status.dart';
import '../domain/entities/oauth_callback_result.dart';
import '../domain/failures/auth_user_failure.dart';
import '../domain/validator/auth_value_object_validator.dart';
import 'auth_oauth_state.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<AuthStatus> build() async {
    final apiClient = ref.read(apiClientProvider)
      ..setOnUnauthorizedCallback(() async {
        await forceLogout();
      });

    // Load persisted tokens from secure storage
    await apiClient.loadTokensFromStorage();

    if (!apiClient.isAuthenticated) {
      return const AuthStatus.unauthenticated();
    }

    return const AuthStatus.authenticated(user: null, account: null);
  }

  Future<void> forceLogout() async {
    final apiClient = ref.read(apiClientProvider);
    await apiClient.clearTokens();
    _clearOAuthTransientState();
    state = const AsyncValue.data(AuthStatus.unauthenticated());
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncValue.loading();
    final repository = ref.read(authRepositoryProvider);

    final result = await repository.login(email: email, password: password);
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
  }) async {
    state = const AsyncValue.loading();
    final repository = ref.read(authRepositoryProvider);

    final result = await repository.register(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (authResponse) {
        final accountStatus = authResponse.account.status.trim().toLowerCase();
        final isPendingVerification =
            accountStatus == 'pending_verification' ||
            accountStatus == 'pending-verification' ||
            accountStatus == 'pending verification' ||
            accountStatus == 'pending';

        if (isPendingVerification) {
          state = const AsyncValue.data(AuthStatus.pendingVerification());
          return;
        }

        _applyAuthenticated(authResponse);
      },
    );
  }

  Future<void> completeVerification() async {
    final apiClient = ref.read(apiClientProvider);
    await apiClient.loadTokensFromStorage();
    state = const AsyncValue.data(
      AuthStatus.authenticated(user: null, account: null),
    );
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    final repository = ref.read(authRepositoryProvider);

    final result = await repository.logout();
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) {
        _clearOAuthTransientState();
        state = const AsyncValue.data(AuthStatus.unauthenticated());
      },
    );
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

  Future<void> startOAuthLogin(String provider) async {
    final oauthStateNotifier = ref.read(authOAuthStateProvider.notifier);
    oauthStateNotifier.state = oauthStateNotifier.state.copyWith(
      oauthInProgress: true,
      oauthProvidersFailure: null,
      pendingOAuthEmail: null,
    );

    try {
      final launched = await launchUrl(
        AppConfig.buildOAuthLoginUri(provider),
        mode: LaunchMode.externalApplication,
      );

      if (launched) {
        return;
      }

      _setOAuthFailure(
        const AuthUserFailure.oauthProviderUnavailable(
          message: 'Unable to open browser for OAuth sign in',
        ),
      );
    } on Exception {
      _setOAuthFailure(
        const AuthUserFailure.oauthProviderUnavailable(
          message: 'Unable to open browser for OAuth sign in',
        ),
      );
    }
  }

  Future<void> handleOAuthDeepLink(Uri uri) async {
    final provider = _extractProviderFromCallback(uri);
    final code = uri.queryParameters['code'];
    final stateParam = uri.queryParameters['state'];

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

    _handleOAuthCallbackResult(result);
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

    _handleOAuthCallbackResult(result);
  }

  void _handleOAuthCallbackResult(
    Either<AuthUserFailure, OAuthCallbackResult> result,
  ) {
    result.fold(
      (failure) {
        _setOAuthFailure(failure);
        state = AsyncValue.error(failure, StackTrace.current);
      },
      (callbackResult) {
        if (callbackResult.isAuthenticated && callbackResult.authResponse != null) {
          _applyAuthenticated(callbackResult.authResponse!);
          return;
        }

        if (callbackResult.isEmailRequired && callbackResult.pendingEmail != null) {
          final oauthStateNotifier = ref.read(authOAuthStateProvider.notifier);
          oauthStateNotifier.state = oauthStateNotifier.state.copyWith(
            oauthInProgress: false,
            pendingOAuthEmail: callbackResult.pendingEmail,
          );
          state = const AsyncValue.data(AuthStatus.unauthenticated());
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

  void _applyAuthenticated(AuthResponse authResponse) {
    _clearOAuthTransientState();
    state = AsyncValue.data(
      AuthStatus.authenticated(
        user: authResponse.user,
        account: authResponse.account,
      ),
    );
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
