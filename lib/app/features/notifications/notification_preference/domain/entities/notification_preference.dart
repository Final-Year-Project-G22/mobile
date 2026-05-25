import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_preference.freezed.dart';
part 'notification_preference.g.dart';

@freezed
abstract class NotificationPreference with _$NotificationPreference {
  const factory NotificationPreference({
    required bool emailEnabled,
    required bool pushEnabled,
  }) = _NotificationPreference;

  factory NotificationPreference.fromJson(Map<String, Object?> json) =>
      _$NotificationPreferenceFromJson(json);
}
