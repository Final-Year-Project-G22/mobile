import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/category_node.dart';
import '../../domain/entities/download_result.dart';
import '../../domain/entities/template_group_detail.dart';
import 'templates_providers.dart';

part 'templates_data_providers.g.dart';

@riverpod
Future<List<CategoryNode>> categories(Ref ref) async {
  final repository = ref.watch(templatesRepositoryProvider);
  final result = await repository.listCategories();

  return result.fold(
    (failure) => throw failure,
    (categories) => categories,
  );
}

@riverpod
Future<TemplateGroupDetail> templateDetail(Ref ref, String slug) async {
  final repository = ref.watch(templatesRepositoryProvider);
  final result = await repository.getTemplateGroupDetail(slug);

  return result.fold(
    (failure) => throw failure,
    (detail) => detail,
  );
}

@riverpod
Future<DownloadResult> downloadTemplate(
  Ref ref, {
  required String slug,
  required String language,
}) async {
  final repository = ref.watch(templatesRepositoryProvider);
  final result = await repository.downloadTemplate(
    slug,
    language: language,
  );

  return result.fold(
    (failure) => throw failure,
    (download) => download,
  );
}
