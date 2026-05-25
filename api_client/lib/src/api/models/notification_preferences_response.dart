// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_preferences_response.freezed.dart';
part 'notification_preferences_response.g.dart';

@Freezed()
abstract class NotificationPreferencesResponse
    with _$NotificationPreferencesResponse {
  const factory NotificationPreferencesResponse({
    required bool emailEnabled,
    required bool pushEnabled,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _NotificationPreferencesResponse;

  factory NotificationPreferencesResponse.fromJson(Map<String, Object?> json) =>
      _$NotificationPreferencesResponseFromJson(json);
}
