// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/add_category_condition_request.dart';
import '../models/add_category_condition_response_body.dart';
import '../models/create_category_request.dart';
import '../models/create_category_response_body.dart';
import '../models/delete_category_response_body.dart';
import '../models/guide_category_tree_admin_response_body.dart';
import '../models/remove_category_condition_response_body.dart';
import '../models/set_category_translations_request.dart';
import '../models/set_category_translations_response_body.dart';
import '../models/update_category_request.dart';
import '../models/update_category_response_body.dart';

part 'admin_categories_client.g.dart';

@RestApi()
abstract class AdminCategoriesClient {
  factory AdminCategoriesClient(Dio dio, {String? baseUrl}) = _AdminCategoriesClient;

  /// Create category.
  ///
  /// Creates a new guide category with optional translations and conditions.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/guides/categories')
  Future<HttpResponse<CreateCategoryResponseBody>> createCategory({@Body() required CreateCategoryRequest body});

  /// Remove category condition.
  ///
  /// Removes a visibility condition from a category.
  ///
  /// [condId] - Condition ID.
  @DELETE('/api/v1/admin/guides/categories/conditions/{condId}')
  Future<HttpResponse<RemoveCategoryConditionResponseBody>> removeCategoryCondition({
    @Path('condId') required String condId,
  });

  /// Get admin guide category tree.
  ///
  /// Retrieves guide categories tree for admin management.
  ///
  /// [includeInactive] - Include inactive categories.
  ///
  /// [locale] - Language locale (en, am).
  @GET('/api/v1/admin/guides/categories/tree')
  Future<HttpResponse<GuideCategoryTreeAdminResponseBody>> getCategoryTreeAdmin({
    @Query('includeInactive') bool? includeInactive,
    @Query('locale') String? locale,
  });

  /// Delete category.
  ///
  /// Deletes a guide category.
  ///
  /// [id] - Category ID.
  @DELETE('/api/v1/admin/guides/categories/{id}')
  Future<HttpResponse<DeleteCategoryResponseBody>> deleteCategory({@Path('id') required String id});

  /// Update category.
  ///
  /// Updates an existing guide category.
  ///
  /// [id] - Category ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PUT('/api/v1/admin/guides/categories/{id}')
  Future<HttpResponse<UpdateCategoryResponseBody>> updateCategory({
    @Path('id') required String id,
    @Body() required UpdateCategoryRequest body,
  });

  /// Add category condition.
  ///
  /// Adds a visibility condition to a category.
  ///
  /// [id] - Category ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/guides/categories/{id}/conditions')
  Future<HttpResponse<AddCategoryConditionResponseBody>> addCategoryCondition({
    @Path('id') required String id,
    @Body() required AddCategoryConditionRequest body,
  });

  /// Set category translations.
  ///
  /// Replaces all translations for a category.
  ///
  /// [id] - Category ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PUT('/api/v1/admin/guides/categories/{id}/translations')
  Future<HttpResponse<SetCategoryTranslationsResponseBody>> setCategoryTranslations({
    @Path('id') required String id,
    @Body() required SetCategoryTranslationsRequest body,
  });
}
