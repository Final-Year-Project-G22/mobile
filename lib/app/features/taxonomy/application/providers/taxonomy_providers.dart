import 'package:api_client/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/di/infra_providers.dart';
import '../../domain/entities/sector.dart';
import '../../domain/entities/tag.dart';
import '../../domain/i_taxonomy_repository.dart';
import '../../infrastructure/taxonomy_repository_impl.dart';

part 'taxonomy_providers.g.dart';

@riverpod
ITaxonomyRepository taxonomyRepository(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  return TaxonomyRepositoryImpl(TaxonomyClient(apiClient.dio));
}

@riverpod
Future<List<Sector>> sectors(Ref ref) async {
  final repository = ref.watch(taxonomyRepositoryProvider);
  final result = await repository.getSectors();

  return result.fold(
    (failure) => throw Exception(failure.toString()),
    (sectors) => sectors,
  );
}

@riverpod
Future<List<Tag>> tags(Ref ref) async {
  final repository = ref.watch(taxonomyRepositoryProvider);
  final result = await repository.getTags();

  return result.fold(
    (failure) => throw Exception(failure.toString()),
    (tags) => tags,
  );
}
