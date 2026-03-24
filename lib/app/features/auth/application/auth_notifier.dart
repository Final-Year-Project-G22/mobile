import 'package:mobile/app/features/auth/domain/entities/auth_status.dart';
import 'package:mobile/core/di/auth_providers.dart';
import 'package:mobile/core/di/infra_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<AuthStatus> build() async {
    final tokenStorage = ref.read(tokenStorageProvider);
    final apiClient = ref.read(apiClientProvider);

    // Wire up onUnauthorized callback
    apiClient.setOnUnauthorizedCallback(() async {
      await forceLogout();
    });

    final tokens = await tokenStorage.readTokens();
    if (tokens == null) {
      return const AuthStatus.unauthenticated();
    }
    apiClient.setTokens(tokens.accessToken, tokens.refreshToken);
    return const AuthStatus.authenticated(user: null, account: null);
  }

  Future<void> forceLogout() async {
    final tokenStorage = ref.read(tokenStorageProvider);
    final apiClient = ref.read(apiClientProvider);
    await tokenStorage.clear();
    apiClient.clearTokens();
    state = const AsyncValue.data(AuthStatus.unauthenticated());
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncValue.loading();
    final repository = ref.read(authRepositoryProvider);

    final result = await repository.login(email: email, password: password);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (authResponse) =>
          state = AsyncValue.data(AuthStatus.authenticated(user: authResponse.user, account: authResponse.account)),
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
      (authResponse) =>
          state = AsyncValue.data(AuthStatus.authenticated(user: authResponse.user, account: authResponse.account)),
    );
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    final repository = ref.read(authRepositoryProvider);

    final result = await repository.logout();
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => state = const AsyncValue.data(AuthStatus.unauthenticated()),
    );
  }
}
