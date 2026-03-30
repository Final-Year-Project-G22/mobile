import 'package:api_client/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app/features/auth/domain/i_auth_repository.dart';
import '../../app/features/auth/infrastructure/auth_repository_impl.dart';
import 'infra_providers.dart';

part 'auth_providers.g.dart';

@riverpod
IAuthRepository authRepository(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  final dio = apiClient.dio;
  final client = AuthenticationClient(dio);
  return AuthRepositoryImpl(client, apiClient);
}
