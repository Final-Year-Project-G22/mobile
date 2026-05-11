// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/add_guide_condition_request.dart';
import '../models/add_guide_condition_response_body.dart';
import '../models/create_guide_request.dart';
import '../models/create_guide_response_body.dart';
import '../models/delete_guide_response_body.dart';
import '../models/get_guide_admin_response_body.dart';
import '../models/list_guides_admin_response_body.dart';
import '../models/remove_guide_condition_response_body.dart';
import '../models/set_guide_translations_request.dart';
import '../models/set_guide_translations_response_body.dart';
import '../models/update_guide_request.dart';
import '../models/update_guide_response_body.dart';

part 'admin_guides_client.g.dart';

@RestApi()
abstract class AdminGuidesClient {
  factory AdminGuidesClient(Dio dio, {String? baseUrl}) = _AdminGuidesClient;

  /// List guides.
  ///
  /// Lists guides for admin management with pagination and filters.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Items per page.
  ///
  /// [search] - Search keyword.
  ///
  /// [sortBy] - Sort columns.
  ///
  /// [sortOrder] - Sort order (asc, desc).
  ///
  /// [locale] - Language locale (en, am).
  @GET('/api/v1/admin/guides')
  Future<HttpResponse<ListGuidesAdminResponseBody>> listGuidesAdmin({
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('search') String? search,
    @Query('sortBy') List<dynamic>? sortBy,
    @Query('sortOrder') List<dynamic>? sortOrder,
    @Query('locale') String? locale,
  });

  /// Create guide.
  ///
  /// Creates a new guide with optional translations and conditions.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/guides')
  Future<HttpResponse<CreateGuideResponseBody>> createGuide({@Body() required CreateGuideRequest body});

  /// Remove guide condition.
  ///
  /// Removes a visibility condition from a guide.
  ///
  /// [condId] - Condition ID.
  @DELETE('/api/v1/admin/guides/conditions/{condId}')
  Future<HttpResponse<RemoveGuideConditionResponseBody>> removeGuideCondition({@Path('condId') required String condId});

  /// Delete guide.
  ///
  /// Deletes a guide.
  ///
  /// [id] - Guide ID.
  @DELETE('/api/v1/admin/guides/{id}')
  Future<HttpResponse<DeleteGuideResponseBody>> deleteGuide({@Path('id') required String id});

  /// Get guide detail.
  ///
  /// Retrieves guide detail for admin editor.
  ///
  /// [id] - Guide ID.
  ///
  /// [locale] - Language locale (en, am).
  @GET('/api/v1/admin/guides/{id}')
  Future<HttpResponse<GetGuideAdminResponseBody>> getGuideAdmin({
    @Path('id') required String id,
    @Query('locale') String? locale,
  });

  /// Update guide.
  ///
  /// Updates an existing guide.
  ///
  /// [id] - Guide ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PUT('/api/v1/admin/guides/{id}')
  Future<HttpResponse<UpdateGuideResponseBody>> updateGuide({
    @Path('id') required String id,
    @Body() required UpdateGuideRequest body,
  });

  /// Add guide condition.
  ///
  /// Adds a visibility condition to a guide.
  ///
  /// [id] - Guide ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/guides/{id}/conditions')
  Future<HttpResponse<AddGuideConditionResponseBody>> addGuideCondition({
    @Path('id') required String id,
    @Body() required AddGuideConditionRequest body,
  });

  /// Set guide translations.
  ///
  /// Replaces all translations for a guide.
  ///
  /// [id] - Guide ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PUT('/api/v1/admin/guides/{id}/translations')
  Future<HttpResponse<SetGuideTranslationsResponseBody>> setGuideTranslations({
    @Path('id') required String id,
    @Body() required SetGuideTranslationsRequest body,
  });
}
