import 'package:dartz/dartz.dart';

import 'entities/scheduled_alert.dart';
import 'entities/scheduled_alert_template.dart';
import 'failures/scheduled_alert_failure.dart';

abstract class IScheduledAlertRepository {
  Future<Either<ScheduledAlertFailure, List<ScheduledAlert>>> list();
  Future<Either<ScheduledAlertFailure, ScheduledAlert>> create({
    required String? templateSlug,
    required String title,
    required String body,
    required List<String> channels,
    required DateTime scheduledFor,
  });
  Future<Either<ScheduledAlertFailure, void>> cancel(String id);
  Future<Either<ScheduledAlertFailure, void>> reschedule(
    String id, {
    required DateTime newScheduledFor,
  });
  Future<Either<ScheduledAlertFailure, List<ScheduledAlertTemplate>>>
      listTemplates();
}
