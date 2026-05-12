// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'notification_summary_response.dart';

part 'inbox_entry_response.freezed.dart';
part 'inbox_entry_response.g.dart';

@Freezed()
abstract class InboxEntryResponse with _$InboxEntryResponse {
  const factory InboxEntryResponse({
    /// Inbox entry ID
    required String id,

    /// Whether the notification has been archived
    required bool isArchived,

    /// Whether the notification has been read
    required bool isRead,

    /// Notification details
    required NotificationSummaryResponse notification,

    /// Action URL
    String? actionUrl,

    /// Expiration time
    DateTime? expiresAt,
  }) = _InboxEntryResponse;

  factory InboxEntryResponse.fromJson(Map<String, Object?> json) => _$InboxEntryResponseFromJson(json);
}
