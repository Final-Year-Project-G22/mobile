import 'package:dartz/dartz.dart';

import 'entities/notification_preference.dart';
import 'failures/notification_preference_failure.dart';

abstract class INotificationPreferenceRepository {
  Future<Either<NotificationPreferenceFailure, NotificationPreference>> get();
  Future<Either<NotificationPreferenceFailure, NotificationPreference>> update({
    required bool emailEnabled,
    required bool pushEnabled,
  });
}
