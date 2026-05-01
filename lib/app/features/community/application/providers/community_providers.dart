import 'package:api_client/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/di/infra_providers.dart';
import '../../domain/i_community_repository.dart';
import '../../infrastructure/community_repository_impl.dart';

part 'community_providers.g.dart';

@riverpod
ICommunityRepository communityRepository(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  return CommunityRepositoryImpl(CommunityClient(apiClient.dio));
}
