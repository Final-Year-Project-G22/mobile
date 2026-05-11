import 'package:api_client/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app/features/business_profile/domain/i_business_profile_repository.dart';
import '../../app/features/business_profile/infrastructure/business_profile_repository_impl.dart';
import 'infra_providers.dart';

part 'business_profile_providers.g.dart';

@riverpod
IBusinessProfileRepository businessProfileRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  final dio = apiClient.dio;
  final client = BusinessProfileClient(dio);
  return BusinessProfileRepositoryImpl(client);
}

@riverpod
TaxonomyClient taxonomyClient(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return TaxonomyClient(apiClient.dio);
}
