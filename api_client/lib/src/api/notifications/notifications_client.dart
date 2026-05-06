// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/archive_notification_response_body.dart';
import '../models/deactivate_device_response_body.dart';
import '../models/delete_notification_response_body.dart';
import '../models/delete_preference_response_body.dart';
import '../models/device_response.dart';
import '../models/history_entry_response.dart';
import '../models/list_history_response_body.dart';
import '../models/list_inbox_response_body.dart';
import '../models/list_mutes_response_body.dart';
import '../models/mark_all_as_read_response_body.dart';
import '../models/mark_as_read_response_body.dart';
import '../models/mark_category_as_read_response_body.dart';
import '../models/mute_account_request.dart';
import '../models/mute_account_response_body.dart';
import '../models/register_device_request.dart';
import '../models/register_device_response_body.dart';
import '../models/set_preference_request.dart';
import '../models/set_preference_response_body.dart';
import '../models/unmute_account_response_body.dart';
import '../models/unread_count_response_body.dart';
import '../models/update_device_request.dart';

part 'notifications_client.g.dart';

@RestApi()
abstract class NotificationsClient {
  factory NotificationsClient(Dio dio, {String? baseUrl}) = _NotificationsClient;

  /// List devices.
  ///
  /// Lists all registered devices for the authenticated user.
  @GET('/api/v1/notifications/devices')
  Future<HttpResponse<dynamic>> listDevices();

  /// Register device.
  ///
  /// Registers a new device or updates an existing one by device token.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/notifications/devices')
  Future<HttpResponse<RegisterDeviceResponseBody>> registerDevice({@Body() required RegisterDeviceRequest body});

  /// Deactivate device.
  ///
  /// Deactivates a registered device.
  ///
  /// [id] - Device ID.
  @DELETE('/api/v1/notifications/devices/{id}')
  Future<HttpResponse<DeactivateDeviceResponseBody>> deactivateDevice({@Path('id') required String id});

  /// Update device.
  ///
  /// Updates device metadata such as push token or device name.
  ///
  /// [id] - Device ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PATCH('/api/v1/notifications/devices/{id}')
  Future<HttpResponse<DeviceResponse>> updateDevice({
    @Path('id') required String id,
    @Body() required UpdateDeviceRequest body,
  });

  /// List history.
  ///
  /// Lists the authenticated user's notification history.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Items per page.
  @GET('/api/v1/notifications/history')
  Future<HttpResponse<ListHistoryResponseBody>> listHistory({
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  });

  /// Get history detail.
  ///
  /// Gets a single notification history entry.
  ///
  /// [id] - History entry ID.
  @GET('/api/v1/notifications/history/{id}')
  Future<HttpResponse<HistoryEntryResponse>> getHistoryDetail({@Path('id') required String id});

  /// List inbox.
  ///
  /// Lists the authenticated user's inbox with optional category filter.
  ///
  /// [category] - Filter by notification category.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Items per page.
  @GET('/api/v1/notifications/inbox')
  Future<HttpResponse<ListInboxResponseBody>> listInbox({
    @Query('category') String? category,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
  });

  /// Mark category as read.
  ///
  /// Marks all inbox notifications in a category as read.
  ///
  /// [category] - Notification category.
  @POST('/api/v1/notifications/inbox/category/{category}/read')
  Future<HttpResponse<MarkCategoryAsReadResponseBody>> markCategoryAsRead({@Path('category') required String category});

  /// Mark all as read.
  ///
  /// Marks all inbox notifications as read for the authenticated user.
  @POST('/api/v1/notifications/inbox/read-all')
  Future<HttpResponse<MarkAllAsReadResponseBody>> markAllAsRead();

  /// Get unread count.
  ///
  /// Returns the number of unread notifications for the authenticated user.
  @GET('/api/v1/notifications/inbox/unread-count')
  Future<HttpResponse<UnreadCountResponseBody>> getUnreadCount();

  /// Delete notification.
  ///
  /// Soft-deletes a single inbox notification.
  ///
  /// [id] - Inbox entry ID.
  @DELETE('/api/v1/notifications/inbox/{id}')
  Future<HttpResponse<DeleteNotificationResponseBody>> deleteNotification({@Path('id') required String id});

  /// Archive notification.
  ///
  /// Archives a single inbox notification.
  ///
  /// [id] - Inbox entry ID.
  @PATCH('/api/v1/notifications/inbox/{id}/archive')
  Future<HttpResponse<ArchiveNotificationResponseBody>> archiveNotification({@Path('id') required String id});

  /// Mark as read.
  ///
  /// Marks a single inbox notification as read.
  ///
  /// [id] - Inbox entry ID.
  @PATCH('/api/v1/notifications/inbox/{id}/read')
  Future<HttpResponse<MarkAsReadResponseBody>> markAsRead({@Path('id') required String id});

  /// List mutes.
  ///
  /// Lists all muted accounts for the authenticated user.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Items per page.
  @GET('/api/v1/notifications/mutes')
  Future<HttpResponse<ListMutesResponseBody>> listMutes({@Query('page') int? page, @Query('pageSize') int? pageSize});

  /// Mute account.
  ///
  /// Mutes an account so their notifications are not shown in the inbox.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/notifications/mutes')
  Future<HttpResponse<MuteAccountResponseBody>> muteAccount({@Body() required MuteAccountRequest body});

  /// Unmute account.
  ///
  /// Unmutes a previously muted account.
  ///
  /// [accountId] - Muted account ID.
  @DELETE('/api/v1/notifications/mutes/{accountId}')
  Future<HttpResponse<UnmuteAccountResponseBody>> unmuteAccount({@Path('accountId') required String accountId});

  /// List preferences.
  ///
  /// Lists all notification preference overrides for the authenticated user.
  @GET('/api/v1/notifications/preferences')
  Future<HttpResponse<dynamic>> listPreferences();

  /// Set preference.
  ///
  /// Sets a notification preference override for a type+channel combination.
  ///
  /// [body] - Name not received - field will be skipped.
  @PUT('/api/v1/notifications/preferences')
  Future<HttpResponse<SetPreferenceResponseBody>> setPreference({@Body() required SetPreferenceRequest body});

  /// Delete preference.
  ///
  /// Deletes a notification preference override, reverting to defaults.
  ///
  /// [type] - Notification type.
  ///
  /// [channel] - Channel.
  @DELETE('/api/v1/notifications/preferences/{type}/{channel}')
  Future<HttpResponse<DeletePreferenceResponseBody>> deletePreference({
    @Path('type') required String type,
    @Path('channel') required String channel,
  });
}
