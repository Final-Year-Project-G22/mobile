// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/add_translation_request.dart';
import '../models/add_translation_response_body.dart';
import '../models/campaign_detail_response.dart';
import '../models/cancel_campaign_response_body.dart';
import '../models/create_campaign_request.dart';
import '../models/create_campaign_response_body.dart';
import '../models/create_template_request.dart';
import '../models/create_template_response_body.dart';
import '../models/delete_template_response_body.dart';
import '../models/delete_translation_response_body.dart';
import '../models/list_campaigns_response_body.dart';
import '../models/list_templates_response_body.dart';
import '../models/queue_status_response.dart';
import '../models/retry_failed_response_body.dart';
import '../models/schedule_campaign_response_body.dart';
import '../models/template_detail_response.dart';
import '../models/update_campaign_request.dart';
import '../models/update_campaign_response_body.dart';
import '../models/update_template_request.dart';
import '../models/update_template_response_body.dart';
import '../models/update_translation_request.dart';
import '../models/update_translation_response_body.dart';

part 'admin_notifications_client.g.dart';

@RestApi()
abstract class AdminNotificationsClient {
  factory AdminNotificationsClient(Dio dio, {String? baseUrl}) =
      _AdminNotificationsClient;

  /// List campaigns.
  ///
  /// Lists notification campaigns with optional status filter.
  ///
  /// [status] - Filter by status.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Items per page.
  @GET('/api/v1/admin/notifications/campaigns')
  Future<HttpResponse<ListCampaignsResponseBody>> listCampaigns({
    @Query('status') String? status,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  });

  /// Create campaign.
  ///
  /// Creates a new notification campaign in draft status.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/notifications/campaigns')
  Future<HttpResponse<CreateCampaignResponseBody>> createCampaign({
    @Body() required CreateCampaignRequest body,
  });

  /// Get campaign.
  ///
  /// Gets a notification campaign by ID.
  ///
  /// [id] - Campaign ID.
  @GET('/api/v1/admin/notifications/campaigns/{id}')
  Future<HttpResponse<CampaignDetailResponse>> getCampaign({
    @Path('id') required String id,
  });

  /// Update campaign.
  ///
  /// Updates a draft notification campaign.
  ///
  /// [id] - Campaign ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PATCH('/api/v1/admin/notifications/campaigns/{id}')
  Future<HttpResponse<UpdateCampaignResponseBody>> updateCampaign({
    @Path('id') required String id,
    @Body() required UpdateCampaignRequest body,
  });

  /// Cancel campaign.
  ///
  /// Cancels a scheduled or sending campaign.
  ///
  /// [id] - Campaign ID.
  @POST('/api/v1/admin/notifications/campaigns/{id}/cancel')
  Future<HttpResponse<CancelCampaignResponseBody>> cancelCampaign({
    @Path('id') required String id,
  });

  /// Schedule campaign.
  ///
  /// Schedules a draft campaign, resolving segment filters to a static recipient list.
  ///
  /// [id] - Campaign ID.
  @POST('/api/v1/admin/notifications/campaigns/{id}/schedule')
  Future<HttpResponse<ScheduleCampaignResponseBody>> scheduleCampaign({
    @Path('id') required String id,
  });

  /// Retry failed.
  ///
  /// Retries failed notification queue items.
  ///
  /// [batchSize] - Number of failed items to retry.
  @POST('/api/v1/admin/notifications/queue/retry')
  Future<HttpResponse<RetryFailedResponseBody>> retryFailed({
    @Query('batchSize') int? batchSize = 50,
  });

  /// Get queue status.
  ///
  /// Returns notification queue counts by status.
  @GET('/api/v1/admin/notifications/queue/status')
  Future<HttpResponse<QueueStatusResponse>> getQueueStatus();

  /// List templates.
  ///
  /// Lists notification templates with optional category filter.
  ///
  /// [templateGroup] - Filter by template group.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Items per page.
  @GET('/api/v1/admin/notifications/templates')
  Future<HttpResponse<ListTemplatesResponseBody>> listTemplates({
    @Query('templateGroup') String? templateGroup,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  });

  /// Create template.
  ///
  /// Creates a new notification template.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/notifications/templates')
  Future<HttpResponse<CreateTemplateResponseBody>> createTemplate({
    @Body() required CreateTemplateRequest body,
  });

  /// Delete template.
  ///
  /// Soft-deletes a notification template. System-managed templates cannot be deleted.
  ///
  /// [id] - Template ID.
  @DELETE('/api/v1/admin/notifications/templates/{id}')
  Future<HttpResponse<DeleteTemplateResponseBody>> deleteTemplate({
    @Path('id') required String id,
  });

  /// Get template.
  ///
  /// Gets a notification template with its translations.
  ///
  /// [id] - Template ID.
  @GET('/api/v1/admin/notifications/templates/{id}')
  Future<HttpResponse<TemplateDetailResponse>> getTemplate({
    @Path('id') required String id,
  });

  /// Update template.
  ///
  /// Updates a notification template. System-managed templates have restricted fields.
  ///
  /// [id] - Template ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PATCH('/api/v1/admin/notifications/templates/{id}')
  Future<HttpResponse<UpdateTemplateResponseBody>> updateTemplate({
    @Path('id') required String id,
    @Body() required UpdateTemplateRequest body,
  });

  /// Add translation.
  ///
  /// Adds a translation to a notification template.
  ///
  /// [id] - Template ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/notifications/templates/{id}/translations')
  Future<HttpResponse<AddTranslationResponseBody>> addTranslation({
    @Path('id') required String id,
    @Body() required AddTranslationRequest body,
  });

  /// Delete translation.
  ///
  /// Deletes a translation from a notification template.
  ///
  /// [id] - Template ID.
  ///
  /// [lang] - Language code.
  @DELETE('/api/v1/admin/notifications/templates/{id}/translations/{lang}')
  Future<HttpResponse<DeleteTranslationResponseBody>> deleteTranslation({
    @Path('id') required String id,
    @Path('lang') required String lang,
  });

  /// Update translation.
  ///
  /// Updates an existing translation for a notification template.
  ///
  /// [id] - Template ID.
  ///
  /// [lang] - Language code.
  ///
  /// [body] - Name not received - field will be skipped.
  @PATCH('/api/v1/admin/notifications/templates/{id}/translations/{lang}')
  Future<HttpResponse<UpdateTranslationResponseBody>> updateTranslation({
    @Path('id') required String id,
    @Path('lang') required String lang,
    @Body() required UpdateTranslationRequest body,
  });
}
