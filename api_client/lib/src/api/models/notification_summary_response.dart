// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_summary_response.freezed.dart';
part 'notification_summary_response.g.dart';

@Freezed()
abstract class NotificationSummaryResponse with _$NotificationSummaryResponse {
  const factory NotificationSummaryResponse({
    /// Delivery channel
    required String channel,

    /// Notification content
    required String content,

    /// Notification type
    required String notificationType,

    /// Time the notification was sent
    required DateTime sentAt,

    /// Notification title
    required String title,

    /// Time the notification was delivered
    DateTime? deliveredAt,

    /// Time the notification was read
    DateTime? readAt,
  }) = _NotificationSummaryResponse;

  factory NotificationSummaryResponse.fromJson(Map<String, Object?> json) =>
      _$NotificationSummaryResponseFromJson(json);
}
