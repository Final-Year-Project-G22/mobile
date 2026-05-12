// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'dart:convert';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/add_category_translation_output_body.dart';
import '../models/add_category_translation_request.dart';
import '../models/category_detail_response.dart';
import '../models/create_interactive_form_output_body.dart';
import '../models/create_interactive_form_request.dart';
import '../models/create_library_category_output_body.dart';
import '../models/create_library_category_request.dart';
import '../models/create_template_group_output_body.dart';
import '../models/create_template_group_request.dart';
import '../models/delete_category_translation_output_body.dart';
import '../models/delete_interactive_form_output_body.dart';
import '../models/delete_template_group_output_body.dart';
import '../models/download_log_list_response.dart';
import '../models/interactive_form_detail_response.dart';
import '../models/library_create_template_output_body.dart';
import '../models/library_delete_category_output_body.dart';
import '../models/library_delete_template_output_body.dart';
import '../models/library_template_detail_response.dart';
import '../models/template_group_detail_response.dart';
import '../models/update_category_translation_output_body.dart';
import '../models/update_category_translation_request.dart';
import '../models/update_interactive_form_request.dart';
import '../models/update_library_category_request.dart';
import '../models/update_template_group_request.dart';

part 'admin_library_client.g.dart';

@RestApi()
abstract class AdminLibraryClient {
  factory AdminLibraryClient(Dio dio, {String? baseUrl}) = _AdminLibraryClient;

  /// List all categories.
  ///
  /// Lists categories, optionally including inactive.
  ///
  /// [includeInactive] - Include inactive categories.
  @GET('/api/v1/admin/library/categories')
  Future<HttpResponse<dynamic>> libraryListAllCategories({@Query('includeInactive') bool? includeInactive = false});

  /// Create category.
  ///
  /// Creates a new library category.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/library/categories')
  Future<HttpResponse<CreateLibraryCategoryOutputBody>> libraryCreateCategory({
    @Body() required CreateLibraryCategoryRequest body,
  });

  /// Delete category.
  ///
  /// Soft-deletes a category. Fails if it has active template groups.
  ///
  /// [id] - Category ID.
  @DELETE('/api/v1/admin/library/categories/{id}')
  Future<HttpResponse<LibraryDeleteCategoryOutputBody>> libraryDeleteCategory({@Path('id') required String id});

  /// Get category.
  ///
  /// Gets a category with translations.
  ///
  /// [id] - Category ID.
  @GET('/api/v1/admin/library/categories/{id}')
  Future<HttpResponse<CategoryDetailResponse>> libraryGetCategory({@Path('id') required String id});

  /// Update category.
  ///
  /// Updates a category's metadata.
  ///
  /// [id] - Category ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PATCH('/api/v1/admin/library/categories/{id}')
  Future<HttpResponse<CategoryDetailResponse>> libraryUpdateCategory({
    @Path('id') required String id,
    @Body() required UpdateLibraryCategoryRequest body,
  });

  /// Add category translation.
  ///
  /// Adds a translation for a category.
  ///
  /// [id] - Category ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/library/categories/{id}/translations')
  Future<HttpResponse<AddCategoryTranslationOutputBody>> libraryAddCategoryTranslation({
    @Path('id') required String id,
    @Body() required AddCategoryTranslationRequest body,
  });

  /// Delete category translation.
  ///
  /// Removes a category translation.
  ///
  /// [id] - Category ID.
  ///
  /// [lang] - Language code.
  @DELETE('/api/v1/admin/library/categories/{id}/translations/{lang}')
  Future<HttpResponse<DeleteCategoryTranslationOutputBody>> libraryDeleteCategoryTranslation({
    @Path('id') required String id,
    @Path('lang') required String lang,
  });

  /// Update category translation.
  ///
  /// Updates an existing category translation.
  ///
  /// [id] - Category ID.
  ///
  /// [lang] - Language code.
  ///
  /// [body] - Name not received - field will be skipped.
  @PATCH('/api/v1/admin/library/categories/{id}/translations/{lang}')
  Future<HttpResponse<UpdateCategoryTranslationOutputBody>> libraryUpdateCategoryTranslation({
    @Path('id') required String id,
    @Path('lang') required String lang,
    @Body() required UpdateCategoryTranslationRequest body,
  });

  /// Get download logs.
  ///
  /// Lists download history with optional group filter.
  ///
  /// [groupId] - Filter by template group ID.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Items per page.
  @GET('/api/v1/admin/library/downloads')
  Future<HttpResponse<DownloadLogListResponse>> libraryGetDownloadLogs({
    @Query('page') int? page = 1,
    @Query('pageSize') int? pageSize = 20,
    @Query('groupId') String? groupId,
  });

  /// Delete interactive form.
  ///
  /// Soft-deletes an interactive form.
  ///
  /// [id] - Form ID.
  @DELETE('/api/v1/admin/library/interactive-forms/{id}')
  Future<HttpResponse<DeleteInteractiveFormOutputBody>> libraryDeleteInteractiveForm({@Path('id') required String id});

  /// Update interactive form.
  ///
  /// Updates an interactive form's layout.
  ///
  /// [id] - Form ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PATCH('/api/v1/admin/library/interactive-forms/{id}')
  Future<HttpResponse<InteractiveFormDetailResponse>> libraryUpdateInteractiveForm({
    @Path('id') required String id,
    @Body() required UpdateInteractiveFormRequest body,
  });

  /// List template groups.
  ///
  /// Lists all template groups with optional category filter.
  ///
  /// [categoryId] - Filter by category ID.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Items per page.
  @GET('/api/v1/admin/library/template-groups')
  Future<HttpResponse<dynamic>> libraryListAllTemplateGroups({
    @Query('page') int? page = 1,
    @Query('pageSize') int? pageSize = 20,
    @Query('categoryId') String? categoryId,
  });

  /// Create template group.
  ///
  /// Creates a new template group with metadata.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/library/template-groups')
  Future<HttpResponse<CreateTemplateGroupOutputBody>> libraryCreateTemplateGroup({
    @Body() required CreateTemplateGroupRequest body,
  });

  /// Delete template group.
  ///
  /// Soft-deletes a template group.
  ///
  /// [groupId] - Group ID.
  @DELETE('/api/v1/admin/library/template-groups/{groupId}')
  Future<HttpResponse<DeleteTemplateGroupOutputBody>> libraryDeleteTemplateGroup({
    @Path('groupId') required String groupId,
  });

  /// Get template group.
  ///
  /// Gets a template group with all templates.
  ///
  /// [groupId] - Group ID.
  @GET('/api/v1/admin/library/template-groups/{groupId}')
  Future<HttpResponse<TemplateGroupDetailResponse>> libraryAdminGetTemplateGroup({
    @Path('groupId') required String groupId,
  });

  /// Update template group.
  ///
  /// Updates a template group's metadata.
  ///
  /// [groupId] - Group ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PATCH('/api/v1/admin/library/template-groups/{groupId}')
  Future<HttpResponse<TemplateGroupDetailResponse>> libraryUpdateTemplateGroup({
    @Path('groupId') required String groupId,
    @Body() required UpdateTemplateGroupRequest body,
  });

  /// List templates by group.
  ///
  /// Lists all template variants for a group.
  ///
  /// [groupId] - Group ID.
  @GET('/api/v1/admin/library/template-groups/{groupId}/templates')
  Future<HttpResponse<dynamic>> libraryListTemplatesByGroup({@Path('groupId') required String groupId});

  /// Create template.
  ///
  /// Uploads a file and creates a template language variant.
  ///
  /// [groupId] - Group ID.
  ///
  /// [description] - Template description.
  /// Name not received - field will be skipped.
  ///
  /// [file] - Template file.
  /// Name not received - field will be skipped.
  ///
  /// [language] - Language code.
  /// Name not received - field will be skipped.
  ///
  /// [title] - Template title.
  /// Name not received - field will be skipped.
  @MultiPart()
  @POST('/api/v1/admin/library/template-groups/{groupId}/templates')
  Future<HttpResponse<LibraryCreateTemplateOutputBody>> libraryCreateTemplate({
    @Path('groupId') required String groupId,
    @Part(name: 'description') required String description,
    @Part(name: 'file') required MultipartFile file,
    @Part(name: 'language') required String language,
    @Part(name: 'title') required String title,
  });

  /// Delete template.
  ///
  /// Soft-deletes a template.
  ///
  /// [templateId] - Template ID.
  @DELETE('/api/v1/admin/library/templates/{templateId}')
  Future<HttpResponse<LibraryDeleteTemplateOutputBody>> libraryDeleteTemplate({
    @Path('templateId') required String templateId,
  });

  /// Get template.
  ///
  /// Gets a template by ID.
  ///
  /// [templateId] - Template ID.
  @GET('/api/v1/admin/library/templates/{templateId}')
  Future<HttpResponse<LibraryTemplateDetailResponse>> libraryGetTemplate({
    @Path('templateId') required String templateId,
  });

  /// Update template.
  ///
  /// Updates template metadata or replaces the file.
  ///
  /// [templateId] - Template ID.
  ///
  /// [description] - Template description.
  /// Name not received - field will be skipped.
  ///
  /// [file] - Template file (optional).
  /// Name not received - field will be skipped.
  ///
  /// [isActive] - Active flag (true/false).
  /// Name not received - field will be skipped.
  ///
  /// [title] - Template title.
  /// Name not received - field will be skipped.
  @MultiPart()
  @PATCH('/api/v1/admin/library/templates/{templateId}')
  Future<HttpResponse<LibraryTemplateDetailResponse>> libraryUpdateTemplate({
    @Path('templateId') required String templateId,
    @Part(name: 'description') required String description,
    @Part(name: 'file') required MultipartFile file,
    @Part(name: 'isActive') required String isActive,
    @Part(name: 'title') required String title,
  });

  /// Get interactive form.
  ///
  /// Gets the interactive form for a template.
  ///
  /// [templateId] - Template ID.
  @GET('/api/v1/admin/library/templates/{templateId}/interactive-form')
  Future<HttpResponse<InteractiveFormDetailResponse>> libraryGetInteractiveForm({
    @Path('templateId') required String templateId,
  });

  /// Create interactive form.
  ///
  /// Creates an interactive form for an interactive template.
  ///
  /// [templateId] - Template ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/library/templates/{templateId}/interactive-form')
  Future<HttpResponse<CreateInteractiveFormOutputBody>> libraryCreateInteractiveForm({
    @Path('templateId') required String templateId,
    @Body() required CreateInteractiveFormRequest body,
  });
}
