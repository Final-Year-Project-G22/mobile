// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/add_campaign_template_translation_request.dart';
import '../models/add_campaign_template_translation_response_body.dart';
import '../models/campaign_template_detail_response.dart';
import '../models/create_campaign_template_request.dart';
import '../models/create_campaign_template_response_body.dart';
import '../models/delete_campaign_template_response_body.dart';
import '../models/delete_campaign_template_translation_response_body.dart';
import '../models/list_campaign_templates_response_body.dart';
import '../models/update_campaign_template_request.dart';
import '../models/update_campaign_template_response_body.dart';
import '../models/update_campaign_template_translation_request.dart';
import '../models/update_campaign_template_translation_response_body.dart';

part 'admin_campaign_templates_client.g.dart';

@RestApi()
abstract class AdminCampaignTemplatesClient {
  factory AdminCampaignTemplatesClient(Dio dio, {String? baseUrl}) =
      _AdminCampaignTemplatesClient;

  /// List campaign templates.
  ///
  /// Lists all campaign templates.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Items per page.
  @GET('/api/v1/admin/notifications/campaign-templates')
  Future<HttpResponse<ListCampaignTemplatesResponseBody>>
  listCampaignTemplates({
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  });

  /// Create campaign template.
  ///
  /// Creates a new campaign template.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/notifications/campaign-templates')
  Future<HttpResponse<CreateCampaignTemplateResponseBody>>
  createCampaignTemplate({@Body() required CreateCampaignTemplateRequest body});

  /// Delete campaign template.
  ///
  /// Deletes a campaign template.
  ///
  /// [id] - Campaign template ID.
  @DELETE('/api/v1/admin/notifications/campaign-templates/{id}')
  Future<HttpResponse<DeleteCampaignTemplateResponseBody>>
  deleteCampaignTemplate({@Path('id') required String id});

  /// Get campaign template.
  ///
  /// Gets a campaign template with its translations.
  ///
  /// [id] - Campaign template ID.
  @GET('/api/v1/admin/notifications/campaign-templates/{id}')
  Future<HttpResponse<CampaignTemplateDetailResponse>> getCampaignTemplate({
    @Path('id') required String id,
  });

  /// Update campaign template.
  ///
  /// Updates a campaign template.
  ///
  /// [id] - Campaign template ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PATCH('/api/v1/admin/notifications/campaign-templates/{id}')
  Future<HttpResponse<UpdateCampaignTemplateResponseBody>>
  updateCampaignTemplate({
    @Path('id') required String id,
    @Body() required UpdateCampaignTemplateRequest body,
  });

  /// Add campaign template translation.
  ///
  /// Adds a translation to a campaign template.
  ///
  /// [id] - Campaign template ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/notifications/campaign-templates/{id}/translations')
  Future<HttpResponse<AddCampaignTemplateTranslationResponseBody>>
  addCampaignTemplateTranslation({
    @Path('id') required String id,
    @Body() required AddCampaignTemplateTranslationRequest body,
  });

  /// Delete campaign template translation.
  ///
  /// Deletes a translation from a campaign template.
  ///
  /// [id] - Campaign template ID.
  ///
  /// [lang] - Language code.
  @DELETE(
    '/api/v1/admin/notifications/campaign-templates/{id}/translations/{lang}',
  )
  Future<HttpResponse<DeleteCampaignTemplateTranslationResponseBody>>
  deleteCampaignTemplateTranslation({
    @Path('id') required String id,
    @Path('lang') required String lang,
  });

  /// Update campaign template translation.
  ///
  /// Updates an existing translation for a campaign template.
  ///
  /// [id] - Campaign template ID.
  ///
  /// [lang] - Language code.
  ///
  /// [body] - Name not received - field will be skipped.
  @PATCH(
    '/api/v1/admin/notifications/campaign-templates/{id}/translations/{lang}',
  )
  Future<HttpResponse<UpdateCampaignTemplateTranslationResponseBody>>
  updateCampaignTemplateTranslation({
    @Path('id') required String id,
    @Path('lang') required String lang,
    @Body() required UpdateCampaignTemplateTranslationRequest body,
  });
}
