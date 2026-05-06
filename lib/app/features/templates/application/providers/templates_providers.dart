import 'package:api_client/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/infra_providers.dart';
import '../../domain/i_templates_repository.dart';
import '../../infrastructure/templates_repository_impl.dart';

part 'templates_providers.g.dart';

@riverpod
ITemplatesRepository templatesRepository(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  return TemplatesRepositoryImpl(LibraryFieldClient(apiClient.dio));
}
