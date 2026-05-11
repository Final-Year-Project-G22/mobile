// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_preference_request.freezed.dart';
part 'set_preference_request.g.dart';

@Freezed()
abstract class SetPreferenceRequest with _$SetPreferenceRequest {
  const factory SetPreferenceRequest({
    /// Channel
    required String channel,

    /// Whether the notification type is enabled for this channel
    required bool isEnabled,

    /// Notification type
    required String notificationType,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Quiet hours end time
    DateTime? quietHoursEnd,

    /// Quiet hours start time
    DateTime? quietHoursStart,
  }) = _SetPreferenceRequest;

  factory SetPreferenceRequest.fromJson(Map<String, Object?> json) =>
      _$SetPreferenceRequestFromJson(json);
}
