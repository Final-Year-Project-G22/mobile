import 'package:dartz/dartz.dart';

import 'entities/category_node.dart';
import 'entities/download_item.dart';
import 'entities/download_result.dart';
import 'entities/template_group.dart';
import 'entities/template_group_detail.dart';
import 'failures/template_failure.dart';

abstract class ITemplatesRepository {
  Future<Either<TemplateFailure, List<CategoryNode>>> listCategories();

  Future<Either<TemplateFailure, List<TemplateGroup>>> listTemplateGroups({
    String? categoryId,
    String? search,
    int page,
    int pageSize,
  });

  Future<Either<TemplateFailure, TemplateGroupDetail>> getTemplateGroupDetail(
    String groupId,
  );

  Future<Either<TemplateFailure, DownloadResult>> downloadTemplate(
    String groupId, {
    String? language,
  });

  Future<Either<TemplateFailure, DownloadResult>> previewTemplate(
    String groupId, {
    String? language,
  });

  Future<Either<TemplateFailure, List<DownloadItem>>> listMyDownloads({
    int page,
    int pageSize,
  });
}
