// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'scheduled_alert_response.freezed.dart';
part 'scheduled_alert_response.g.dart';

@Freezed()
abstract class ScheduledAlertResponse with _$ScheduledAlertResponse {
  const factory ScheduledAlertResponse({
    required String body,
    required List<dynamic>? channels,
    required String? createdAt,
    required String id,
    required DateTime scheduledFor,
    required String status,
    required String title,
    DateTime? cancelledAt,
    DateTime? rescheduledFrom,
    DateTime? sentAt,
    String? templateSlug,
  }) = _ScheduledAlertResponse;

  factory ScheduledAlertResponse.fromJson(Map<String, Object?> json) =>
      _$ScheduledAlertResponseFromJson(json);
}
