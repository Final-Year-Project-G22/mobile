import 'package:api_client/api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../domain/entities/category_node.dart';
import '../domain/entities/download_item.dart';
import '../domain/entities/download_result.dart';
import '../domain/entities/language_variant.dart';
import '../domain/entities/template_group.dart';
import '../domain/entities/template_group_detail.dart';
import '../domain/failures/template_failure.dart';
import '../domain/i_templates_repository.dart';

class TemplatesRepositoryImpl implements ITemplatesRepository {
  const TemplatesRepositoryImpl(this._client);

  final LibraryFieldClient _client;

  @override
  Future<Either<TemplateFailure, List<CategoryNode>>> listCategories() async {
    try {
      final response = await _client.libraryListCategories();
      final data = response.data;

      if (data is! List<dynamic>) {
        return const Right([]);
      }

      final categories = data
          .map((e) => CategoryNodeResponse.fromJson(e as Map<String, dynamic>))
          .map(_mapCategoryNodeResponse)
          .toList();

      return Right(categories);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(TemplateFailure.serverError());
    }
  }

  @override
  Future<Either<TemplateFailure, List<TemplateGroup>>> listTemplateGroups({
    String? categoryId,
    String? search,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _client.libraryListTemplateGroups(
        categoryId: categoryId,
        search: search,
        page: page,
        pageSize: pageSize,
      );

      final items = (response.data.data ?? [])
          .map(
            (e) =>
                TemplateGroupCardResponse.fromJson(e as Map<String, dynamic>),
          )
          .map(_mapTemplateGroupCard)
          .toList();

      return Right(items);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(TemplateFailure.serverError());
    }
  }

  @override
  Future<Either<TemplateFailure, TemplateGroupDetail>> getTemplateGroupDetail(
    String groupId,
  ) async {
    try {
      final response = await _client.libraryGetTemplateGroup(
        groupId: groupId,
      );

      final detail = _mapTemplateGroupDetail(response.data);

      // Validate mapped entity — mirror of ProfileRepositoryImpl pattern
      if (detail.failureOption.isSome()) {
        return const Left(TemplateFailure.invalidData());
      }

      return Right(detail);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(TemplateFailure.serverError());
    }
  }

  @override
  Future<Either<TemplateFailure, DownloadResult>> downloadTemplate(
    String groupId, {
    String? language,
  }) async {
    try {
      final response = await _client.libraryDownloadTemplate(
        groupId: groupId,
        language: language,
      );

      final dto = response.data;
      return Right(
        DownloadResult(
          presignedUrl: dto.presignedUrl,
          expiresAt: _parseExpiresAt(dto.expiresAt),
          filename: dto.filename,
          contentType: dto.contentType,
        ),
      );
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(TemplateFailure.serverError());
    }
  }

  @override
  Future<Either<TemplateFailure, DownloadResult>> previewTemplate(
    String groupId, {
    String? language,
  }) async {
    try {
      final response = await _client.libraryPreviewTemplate(
        groupId: groupId,
        language: language,
      );

      final dto = response.data;
      return Right(
        DownloadResult(
          presignedUrl: dto.presignedUrl,
          expiresAt: _parseExpiresAt(dto.expiresAt),
          filename: dto.filename,
          contentType: dto.contentType,
        ),
      );
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(TemplateFailure.serverError());
    }
  }

  @override
  Future<Either<TemplateFailure, List<DownloadItem>>> listMyDownloads({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _client.libraryListMyDownloads(
        page: page,
        pageSize: pageSize,
      );

      final items = (response.data.data ?? [])
          .map((e) => MyDownloadResponse.fromJson(e as Map<String, dynamic>))
          .map(_mapDownloadItem)
          .toList();

      return Right(items);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(TemplateFailure.serverError());
    }
  }

  // ─── Mappers ───

  CategoryNode _mapCategoryNodeResponse(CategoryNodeResponse dto) {
    final children = (dto.children ?? [])
        .whereType<Map<String, dynamic>>()
        .map(CategoryNodeResponse.fromJson)
        .map(_mapCategoryNodeResponse)
        .toList();

    return CategoryNode(
      id: dto.id,
      name: dto.name,
      slug: dto.slug,
      sortOrder: dto.sortOrder,
      icon: dto.icon,
      children: children,
    );
  }

  TemplateGroup _mapTemplateGroupCard(TemplateGroupCardResponse dto) {
    final languages = (dto.languages ?? []).whereType<String>().toList();

    return TemplateGroup(
      id: dto.id,
      name: dto.name,
      slug: dto.slug,
      categoryId: dto.categoryId,
      format: dto.format,
      tierAccess: dto.tierAccess,
      sortOrder: dto.sortOrder,
      downloadCount: dto.downloadCount,
      languages: languages,
      thumbnailUrl: dto.thumbnailUrl,
    );
  }

  TemplateGroupDetail _mapTemplateGroupDetail(
    UserTemplateGroupDetailResponse dto,
  ) {
    final languages = (dto.languages ?? [])
        .whereType<Map<String, dynamic>>()
        .map(LanguageVariantResponse.fromJson)
        .map(
          (l) => LanguageVariant(
            language: l.language,
            title: l.title,
            contentType: l.contentType,
            fileSize: l.fileSize,
            version: l.version,
            description: l.description,
          ),
        )
        .toList();

    return TemplateGroupDetail(
      id: dto.id,
      name: dto.name,
      slug: dto.slug,
      categoryId: dto.categoryId,
      format: dto.format,
      tierAccess: dto.tierAccess,
      requiresAuth: dto.requiresAuth,
      sortOrder: dto.sortOrder,
      defaultLanguage: dto.defaultLanguage,
      downloadCount: dto.downloadCount,
      languages: languages,
      thumbnailUrl: dto.thumbnailUrl,
    );
  }

  DownloadItem _mapDownloadItem(MyDownloadResponse dto) {
    return DownloadItem(
      id: dto.id,
      templateId: dto.templateId,
      groupId: dto.groupId,
      downloadedAt: DateTime.parse(dto.downloadedAt),
    );
  }

  TemplateFailure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionError:
        return const TemplateFailure.networkError();
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;
        final detail = data is Map<String, dynamic>
            ? data['detail'] as String?
            : null;

        if (statusCode == 404) {
          return const TemplateFailure.notFound();
        } else if (statusCode == 401 || statusCode == 403) {
          return const TemplateFailure.unauthorized();
        }
        return TemplateFailure.serverError(detail);
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return const TemplateFailure.serverError();
    }
  }

  DateTime _parseExpiresAt(String value) {
    // 1. Try ISO 8601 first
    final iso = DateTime.tryParse(value);
    if (iso != null) return iso;

    // 2. Try relative formats: "30s", "5m", "30m", "1h"
    final pattern = RegExp(r'^(\d+)([smh])$');
    final match = pattern.firstMatch(value.trim().toLowerCase());

    if (match != null) {
      final amount = int.parse(match.group(1)!);
      final unit = match.group(2)!;

      switch (unit) {
        case 's':
          return DateTime.now().add(Duration(seconds: amount));
        case 'm':
          return DateTime.now().add(Duration(minutes: amount));
        case 'h':
          return DateTime.now().add(Duration(hours: amount));
      }
    }

    // 3. Fallback: 5 minutes from now
    return DateTime.now().add(const Duration(minutes: 5));
  }
}
