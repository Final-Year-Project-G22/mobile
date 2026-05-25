// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_notification_preferences_request.freezed.dart';
part 'update_notification_preferences_request.g.dart';

@Freezed()
abstract class UpdateNotificationPreferencesRequest
    with _$UpdateNotificationPreferencesRequest {
  const factory UpdateNotificationPreferencesRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
    bool? emailEnabled,
    bool? pushEnabled,
  }) = _UpdateNotificationPreferencesRequest;

  factory UpdateNotificationPreferencesRequest.fromJson(
    Map<String, Object?> json,
  ) => _$UpdateNotificationPreferencesRequestFromJson(json);
}
