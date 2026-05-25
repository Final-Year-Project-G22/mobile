import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/entities/notification_preference.dart';
import '../domain/failures/notification_preference_failure.dart';

part 'notification_preference_state.freezed.dart';

@freezed
abstract class NotificationPreferenceState with _$NotificationPreferenceState {
  const factory NotificationPreferenceState({
    NotificationPreference? preference,
    @Default(false) bool isLoading,
    NotificationPreferenceFailure? failure,
  }) = _NotificationPreferenceState;
}
