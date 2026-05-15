import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/category_node.dart';
import '../../domain/entities/download_result.dart';
import '../../domain/entities/template_group_detail.dart';
import 'templates_providers.dart';

part 'templates_data_providers.g.dart';

@Riverpod(keepAlive: true)
Future<List<CategoryNode>> categories(Ref ref) async {
  final repository = ref.watch(templatesRepositoryProvider);
  final result = await repository.listCategories();

  return result.fold(
    (failure) => throw failure,
    (categories) => categories,
  );
}

@Riverpod(keepAlive: true)
Future<TemplateGroupDetail> templateDetail(Ref ref, String groupId) async {
  final repository = ref.watch(templatesRepositoryProvider);
  final result = await repository.getTemplateGroupDetail(groupId);

  return result.fold(
    (failure) => throw failure,
    (detail) => detail,
  );
}

@riverpod
Future<DownloadResult> downloadTemplate(
  Ref ref, {
  required String groupId,
  required String language,
}) async {
  final repository = ref.watch(templatesRepositoryProvider);
  final result = await repository.downloadTemplate(
    groupId,
    language: language,
  );

  return result.fold(
    (failure) => throw failure,
    (download) => download,
  );
}

@riverpod
Future<DownloadResult> previewTemplate(
  Ref ref, {
  required String groupId,
  required String language,
}) async {
  final repository = ref.watch(templatesRepositoryProvider);
  final result = await repository.previewTemplate(
    groupId,
    language: language,
  );

  return result.fold(
    (failure) => throw failure,
    (preview) => preview,
  );
}
