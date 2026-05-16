import 'package:api_client/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app/features/auth/application/auth_notifier.dart';
import '../../app/features/auth/domain/entities/auth_status.dart';
import '../../app/features/auth/domain/i_auth_repository.dart';
import '../../app/features/auth/infrastructure/auth_repository_impl.dart';
import 'infra_providers.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
AsyncValue<AuthStatus> resolvedAuthStatus(Ref ref) {
  return ref.watch(authProvider);
}

@riverpod
IAuthRepository authRepository(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  final dio = apiClient.dio;
  final authClient = AuthenticationClient(dio);
  final oauthClient = OAuthClient(dio);
  return AuthRepositoryImpl(authClient, oauthClient, apiClient);
}

@riverpod
String? currentAccountId(Ref ref) {
  final auth = ref.watch(resolvedAuthStatusProvider).asData?.value;
  return auth?.asAuthenticated?.account.id;
}
