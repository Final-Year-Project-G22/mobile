import 'package:api_client/api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../domain/entities/notification_preference.dart';
import '../domain/failures/notification_preference_failure.dart';
import '../domain/i_notification_preference_repository.dart';

class NotificationPreferenceRepositoryImpl
    implements INotificationPreferenceRepository {
  NotificationPreferenceRepositoryImpl(this.dio);

  final Dio dio;

  @override
  Future<Either<NotificationPreferenceFailure, NotificationPreference>> get() async {
    try {
      final client = NotificationsClient(dio);
      final response = await client.getNotificationPreferences();
      final pref = response.data;
      return Right(NotificationPreference(
        emailEnabled: pref.emailEnabled,
        pushEnabled: pref.pushEnabled,
      ));
    } on DioException catch (e) {
      return Left(_mapFailure(e));
    }
  }

  @override
  Future<Either<NotificationPreferenceFailure, NotificationPreference>> update({
    required bool emailEnabled,
    required bool pushEnabled,
  }) async {
    try {
      final client = NotificationsClient(dio);
      final response = await client.updateNotificationPreferences(
        body: UpdateNotificationPreferencesRequest(
          emailEnabled: emailEnabled,
          pushEnabled: pushEnabled,
        ),
      );
      final pref = response.data;
      return Right(NotificationPreference(
        emailEnabled: pref.emailEnabled,
        pushEnabled: pref.pushEnabled,
      ));
    } on DioException catch (e) {
      return Left(_mapFailure(e));
    }
  }

  NotificationPreferenceFailure _mapFailure(DioException e) {
    if (e.response?.statusCode == 404) {
      return const NotificationPreferenceFailure.notFound();
    }
    return NotificationPreferenceFailure.apiError(
      e.message ?? 'An error occurred',
    );
  }
}
