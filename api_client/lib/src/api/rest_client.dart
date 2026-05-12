// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;

import 'admin_management/admin_management_client.dart';
import 'admin_community/admin_community_client.dart';
import 'admin_guides/admin_guides_client.dart';
import 'admin_journeys/admin_journeys_client.dart';
import 'admin_steps/admin_steps_client.dart';
import 'admin_library/admin_library_client.dart';
import 'admin_campaign_templates/admin_campaign_templates_client.dart';
import 'admin_notifications/admin_notifications_client.dart';
import 'admin_taxonomy/admin_taxonomy_client.dart';
import 'ai_ask/ai_ask_client.dart';
import 'ai_conversations/ai_conversations_client.dart';
import 'ai_dlq/ai_dlq_client.dart';
import 'ai_ingestion/ai_ingestion_client.dart';
import 'ai_ingestion_status/ai_ingestion_status_client.dart';
import 'authentication/authentication_client.dart';
import 'o_auth/o_auth_client.dart';
import 'community/community_client.dart';
import 'guides/guides_client.dart';
import 'library_field/library_field_client.dart';
import 'payments/payments_client.dart';
import 'notifications/notifications_client.dart';
import 'permissions/permissions_client.dart';
import 'roles/roles_client.dart';
import 'taxonomy/taxonomy_client.dart';
import 'taxonomy/taxonomy_client.dart';
import 'users/users_client.dart';
import 'business_profile/business_profile_client.dart';

/// Adisu Backend API `v1.0.0`.
///
/// Backend API for the Adisu platform.
class RestClient {
  RestClient(
    Dio dio, {
    String? baseUrl,
  }) : _dio = dio,
       _baseUrl = baseUrl;

  final Dio _dio;
  final String? _baseUrl;

  static String get version => '1.0.0';

  AdminManagementClient? _adminManagement;
  AdminCommunityClient? _adminCommunity;
  AdminGuidesClient? _adminGuides;
  AdminJourneysClient? _adminJourneys;
  AdminStepsClient? _adminSteps;
  AdminLibraryClient? _adminLibrary;
  AdminCampaignTemplatesClient? _adminCampaignTemplates;
  AdminNotificationsClient? _adminNotifications;
  AdminTaxonomyClient? _adminTaxonomy;
  AiAskClient? _aiAsk;
  AiConversationsClient? _aiConversations;
  AiDlqClient? _aiDlq;
  AiIngestionClient? _aiIngestion;
  AiIngestionStatusClient? _aiIngestionStatus;
  AuthenticationClient? _authentication;
  OAuthClient? _oAuth;
  CommunityClient? _community;
  GuidesClient? _guides;
  LibraryFieldClient? _libraryField;
  PaymentsClient? _payments;
  NotificationsClient? _notifications;
  PermissionsClient? _permissions;
  RolesClient? _roles;
  TaxonomyClient? _taxonomy;
  TaxonomyClient? _taxonomy;
  UsersClient? _users;
  BusinessProfileClient? _businessProfile;

  AdminManagementClient get adminManagement =>
      _adminManagement ??= AdminManagementClient(_dio, baseUrl: _baseUrl);
  AdminManagementClient get adminManagement =>
      _adminManagement ??= AdminManagementClient(_dio, baseUrl: _baseUrl);

  AdminCommunityClient get adminCommunity =>
      _adminCommunity ??= AdminCommunityClient(_dio, baseUrl: _baseUrl);
  AdminCommunityClient get adminCommunity =>
      _adminCommunity ??= AdminCommunityClient(_dio, baseUrl: _baseUrl);

  AdminGuidesClient get adminGuides =>
      _adminGuides ??= AdminGuidesClient(_dio, baseUrl: _baseUrl);
  AdminGuidesClient get adminGuides =>
      _adminGuides ??= AdminGuidesClient(_dio, baseUrl: _baseUrl);

  AdminJourneysClient get adminJourneys =>
      _adminJourneys ??= AdminJourneysClient(_dio, baseUrl: _baseUrl);
  AdminJourneysClient get adminJourneys =>
      _adminJourneys ??= AdminJourneysClient(_dio, baseUrl: _baseUrl);

  AdminStepsClient get adminSteps =>
      _adminSteps ??= AdminStepsClient(_dio, baseUrl: _baseUrl);
  AdminStepsClient get adminSteps =>
      _adminSteps ??= AdminStepsClient(_dio, baseUrl: _baseUrl);

  AdminLibraryClient get adminLibrary =>
      _adminLibrary ??= AdminLibraryClient(_dio, baseUrl: _baseUrl);
  AdminLibraryClient get adminLibrary =>
      _adminLibrary ??= AdminLibraryClient(_dio, baseUrl: _baseUrl);

  AdminCampaignTemplatesClient get adminCampaignTemplates =>
      _adminCampaignTemplates ??= AdminCampaignTemplatesClient(
        _dio,
        baseUrl: _baseUrl,
      );
      _adminCampaignTemplates ??= AdminCampaignTemplatesClient(
        _dio,
        baseUrl: _baseUrl,
      );

  AdminNotificationsClient get adminNotifications =>
      _adminNotifications ??= AdminNotificationsClient(_dio, baseUrl: _baseUrl);

  AdminTaxonomyClient get adminTaxonomy =>
      _adminTaxonomy ??= AdminTaxonomyClient(_dio, baseUrl: _baseUrl);
  AdminTaxonomyClient get adminTaxonomy =>
      _adminTaxonomy ??= AdminTaxonomyClient(_dio, baseUrl: _baseUrl);

  AiAskClient get aiAsk => _aiAsk ??= AiAskClient(_dio, baseUrl: _baseUrl);

  AiConversationsClient get aiConversations =>
      _aiConversations ??= AiConversationsClient(_dio, baseUrl: _baseUrl);
  AiConversationsClient get aiConversations =>
      _aiConversations ??= AiConversationsClient(_dio, baseUrl: _baseUrl);

  AiDlqClient get aiDlq => _aiDlq ??= AiDlqClient(_dio, baseUrl: _baseUrl);

  AiIngestionClient get aiIngestion =>
      _aiIngestion ??= AiIngestionClient(_dio, baseUrl: _baseUrl);
  AiIngestionClient get aiIngestion =>
      _aiIngestion ??= AiIngestionClient(_dio, baseUrl: _baseUrl);

  AiIngestionStatusClient get aiIngestionStatus =>
      _aiIngestionStatus ??= AiIngestionStatusClient(_dio, baseUrl: _baseUrl);

  AuthenticationClient get authentication =>
      _authentication ??= AuthenticationClient(_dio, baseUrl: _baseUrl);
  AuthenticationClient get authentication =>
      _authentication ??= AuthenticationClient(_dio, baseUrl: _baseUrl);

  OAuthClient get oAuth => _oAuth ??= OAuthClient(_dio, baseUrl: _baseUrl);

  CommunityClient get community =>
      _community ??= CommunityClient(_dio, baseUrl: _baseUrl);
  CommunityClient get community =>
      _community ??= CommunityClient(_dio, baseUrl: _baseUrl);

  GuidesClient get guides => _guides ??= GuidesClient(_dio, baseUrl: _baseUrl);

  LibraryFieldClient get libraryField =>
      _libraryField ??= LibraryFieldClient(_dio, baseUrl: _baseUrl);

  NotificationsClient get notifications =>
      _notifications ??= NotificationsClient(_dio, baseUrl: _baseUrl);
  NotificationsClient get notifications =>
      _notifications ??= NotificationsClient(_dio, baseUrl: _baseUrl);

  PermissionsClient get permissions =>
      _permissions ??= PermissionsClient(_dio, baseUrl: _baseUrl);
  PermissionsClient get permissions =>
      _permissions ??= PermissionsClient(_dio, baseUrl: _baseUrl);

  RolesClient get roles => _roles ??= RolesClient(_dio, baseUrl: _baseUrl);

  TaxonomyClient get taxonomy =>
      _taxonomy ??= TaxonomyClient(_dio, baseUrl: _baseUrl);

  TaxonomyClient get taxonomy =>
      _taxonomy ??= TaxonomyClient(_dio, baseUrl: _baseUrl);

  UsersClient get users => _users ??= UsersClient(_dio, baseUrl: _baseUrl);

  BusinessProfileClient get businessProfile =>
      _businessProfile ??= BusinessProfileClient(_dio, baseUrl: _baseUrl);
}
