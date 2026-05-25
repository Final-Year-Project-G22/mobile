import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_preference_failure.freezed.dart';

@freezed
abstract class NotificationPreferenceFailure with _$NotificationPreferenceFailure {
  const factory NotificationPreferenceFailure.apiError(String message) = _ApiError;
  const factory NotificationPreferenceFailure.notFound() = _NotFound;
  const factory NotificationPreferenceFailure.unknown(String message) = _Unknown;
}
