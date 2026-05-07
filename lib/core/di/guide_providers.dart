// GuidesClient is in api_client's src/ but not barrel-exported.
// ignore_for_file: implementation_imports

import 'package:api_client/src/api/guides/guides_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app/features/guide/domain/i_guide_repository.dart';
import '../../app/features/guide/infrastructure/guide_repository_impl.dart';
import 'infra_providers.dart';

part 'guide_providers.g.dart';

@riverpod
IGuideRepository guideRepository(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  final dio = apiClient.dio;
  final guidesClient = GuidesClient(dio);
  return GuideRepositoryImpl(guidesClient);
}
