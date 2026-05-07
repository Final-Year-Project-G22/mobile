// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/download_template_response_body.dart';
import '../models/list_my_downloads_response_body.dart';
import '../models/list_template_groups_response_body.dart';
import '../models/user_template_group_detail_response.dart';

part 'library_field_client.g.dart';

@RestApi()
abstract class LibraryFieldClient {
  factory LibraryFieldClient(Dio dio, {String? baseUrl}) = _LibraryFieldClient;

  /// List categories.
  ///
  /// Lists active categories as a tree, optionally localized.
  ///
  /// [locale] - Language code for localized names.
  @GET('/api/v1/library/categories')
  Future<HttpResponse<dynamic>> libraryListCategories({
    @Query('locale') String? locale,
  });

  /// My downloads.
  ///
  /// Lists the authenticated user's download history.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Items per page.
  @GET('/api/v1/library/downloads')
  Future<HttpResponse<ListMyDownloadsResponseBody>> libraryListMyDownloads({
    @Query('page') int? page = 1,
    @Query('pageSize') int? pageSize = 20,
  });

  /// List template groups.
  ///
  /// Lists active template groups with optional filters.
  ///
  /// [categoryId] - Filter by category ID.
  ///
  /// [format] - Filter by format (pdf, docx, xlsx, interactive_form).
  ///
  /// [search] - Search by name or description.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Items per page.
  @GET('/api/v1/library/templates')
  Future<HttpResponse<ListTemplateGroupsResponseBody>>
  libraryListTemplateGroups({
    @Query('page') int? page = 1,
    @Query('pageSize') int? pageSize = 20,
    @Query('categoryId') String? categoryId,
    @Query('format') String? format,
    @Query('search') String? search,
  });

  /// Get template group.
  ///
  /// Gets a template group with its language variants.
  ///
  /// [groupId] - Template group ID.
  ///
  /// [locale] - Language code.
  @GET('/api/v1/library/templates/{groupId}')
  Future<HttpResponse<UserTemplateGroupDetailResponse>>
  libraryGetTemplateGroup({
    @Path('groupId') required String groupId,
    @Query('locale') String? locale,
  });

  /// Download template.
  ///
  /// Generates a presigned download URL for a template.
  ///
  /// [groupId] - Template group ID.
  ///
  /// [language] - Language code.
  @GET('/api/v1/library/templates/{groupId}/download')
  Future<HttpResponse<DownloadTemplateResponseBody>> libraryDownloadTemplate({
    @Path('groupId') required String groupId,
    @Query('language') String? language,
  });
}
