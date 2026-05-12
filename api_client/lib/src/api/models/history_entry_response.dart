// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_entry_response.freezed.dart';
part 'history_entry_response.g.dart';

@Freezed()
abstract class HistoryEntryResponse with _$HistoryEntryResponse {
  const factory HistoryEntryResponse({
    /// Delivery channel
    required String channel,

    /// Notification content
    required String content,

    /// Current delivery status
    required String deliveryStatus,

    /// History entry ID
    required String id,

    /// Notification type
    required String notificationType,

    /// Time the notification was sent
    required DateTime sentAt,

    /// Notification title
    required String title,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Action URL
    String? actionUrl,

    /// Time the notification was clicked
    DateTime? clickedAt,

    /// Time the notification was delivered
    DateTime? deliveredAt,

    /// Failure reason if delivery failed
    String? failureReason,

    /// Time the notification was read
    DateTime? readAt,
  }) = _HistoryEntryResponse;

  factory HistoryEntryResponse.fromJson(Map<String, Object?> json) => _$HistoryEntryResponseFromJson(json);
}
