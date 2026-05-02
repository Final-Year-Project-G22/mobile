// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/add_step_condition_request.dart';
import '../models/add_step_condition_response_body.dart';
import '../models/add_step_dependency_request.dart';
import '../models/add_step_dependency_response_body.dart';
import '../models/create_step_request.dart';
import '../models/create_step_response_body.dart';
import '../models/delete_step_response_body.dart';
import '../models/get_step_versions_response_body.dart';
import '../models/remove_step_condition_response_body.dart';
import '../models/remove_step_dependency_response_body.dart';
import '../models/reorder_steps_request.dart';
import '../models/reorder_steps_response_body.dart';
import '../models/revert_step_to_version_response_body.dart';
import '../models/set_step_translations_request.dart';
import '../models/set_step_translations_response_body.dart';
import '../models/update_step_request.dart';
import '../models/update_step_response_body.dart';

part 'admin_steps_client.g.dart';

@RestApi()
abstract class AdminStepsClient {
  factory AdminStepsClient(Dio dio, {String? baseUrl}) = _AdminStepsClient;

  /// Create step.
  ///
  /// Creates a new guide step with translations, conditions, and dependencies.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/guides/steps')
  Future<HttpResponse<CreateStepResponseBody>> createStep({
    @Body() required CreateStepRequest body,
  });

  /// Remove step condition.
  ///
  /// Removes a visibility condition from a step.
  ///
  /// [condId] - Condition ID.
  @DELETE('/api/v1/admin/guides/steps/conditions/{condId}')
  Future<HttpResponse<RemoveStepConditionResponseBody>> removeStepCondition({
    @Path('condId') required String condId,
  });

  /// Remove step dependency.
  ///
  /// Removes a dependency from a step.
  ///
  /// [depId] - Dependency ID.
  @DELETE('/api/v1/admin/guides/steps/dependencies/{depId}')
  Future<HttpResponse<RemoveStepDependencyResponseBody>> removeStepDependency({
    @Path('depId') required String depId,
  });

  /// Reorder steps.
  ///
  /// Reorders the steps of a guide.
  ///
  /// [body] - Name not received - field will be skipped.
  @PUT('/api/v1/admin/guides/steps/reorder')
  Future<HttpResponse<ReorderStepsResponseBody>> reorderSteps({
    @Body() required ReorderStepsRequest body,
  });

  /// Delete step.
  ///
  /// Deletes a guide step.
  ///
  /// [id] - Step ID.
  @DELETE('/api/v1/admin/guides/steps/{id}')
  Future<HttpResponse<DeleteStepResponseBody>> deleteStep({
    @Path('id') required String id,
  });

  /// Update step.
  ///
  /// Updates an existing guide step.
  ///
  /// [id] - Step ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PUT('/api/v1/admin/guides/steps/{id}')
  Future<HttpResponse<UpdateStepResponseBody>> updateStep({
    @Path('id') required String id,
    @Body() required UpdateStepRequest body,
  });

  /// Add step condition.
  ///
  /// Adds a visibility condition to a step.
  ///
  /// [id] - Step ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/guides/steps/{id}/conditions')
  Future<HttpResponse<AddStepConditionResponseBody>> addStepCondition({
    @Path('id') required String id,
    @Body() required AddStepConditionRequest body,
  });

  /// Add step dependency.
  ///
  /// Adds a dependency to a step.
  ///
  /// [id] - Step ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/guides/steps/{id}/dependencies')
  Future<HttpResponse<AddStepDependencyResponseBody>> addStepDependency({
    @Path('id') required String id,
    @Body() required AddStepDependencyRequest body,
  });

  /// Set step translations.
  ///
  /// Replaces all translations for a step.
  ///
  /// [id] - Step ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PUT('/api/v1/admin/guides/steps/{id}/translations')
  Future<HttpResponse<SetStepTranslationsResponseBody>> setStepTranslations({
    @Path('id') required String id,
    @Body() required SetStepTranslationsRequest body,
  });

  /// Get step versions.
  ///
  /// Lists all versions of a step.
  ///
  /// [id] - Step ID.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Items per page.
  @GET('/api/v1/admin/guides/steps/{id}/versions')
  Future<HttpResponse<GetStepVersionsResponseBody>> getStepVersions({
    @Path('id') required String id,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  });

  /// Revert step to version.
  ///
  /// Reverts a step to a previous version (not yet supported).
  ///
  /// [id] - Step ID.
  ///
  /// [version] - Version number to revert to.
  @POST('/api/v1/admin/guides/steps/{id}/versions/{version}/revert')
  Future<HttpResponse<RevertStepToVersionResponseBody>> revertStepToVersion({
    @Path('id') required String id,
    @Path('version') required int version,
  });
}
