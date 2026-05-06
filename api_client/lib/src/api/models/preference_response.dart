// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'preference_response.freezed.dart';
part 'preference_response.g.dart';

@Freezed()
abstract class PreferenceResponse with _$PreferenceResponse {
  const factory PreferenceResponse({
    /// Channel
    required String channel,

    /// Whether enabled
    required bool isEnabled,

    /// Notification type
    required String notificationType,

    /// Quiet hours end time
    DateTime? quietHoursEnd,

    /// Quiet hours start time
    DateTime? quietHoursStart,
  }) = _PreferenceResponse;

  factory PreferenceResponse.fromJson(Map<String, Object?> json) => _$PreferenceResponseFromJson(json);
}
