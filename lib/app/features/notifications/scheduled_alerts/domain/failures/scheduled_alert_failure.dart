import 'package:freezed_annotation/freezed_annotation.dart';

part 'scheduled_alert_failure.freezed.dart';

@freezed
abstract class ScheduledAlertFailure with _$ScheduledAlertFailure {
  const factory ScheduledAlertFailure.unableToCreate([String? message]) = _UnableToCreate;
  const factory ScheduledAlertFailure.unableToCancel([String? message]) = _UnableToCancel;
  const factory ScheduledAlertFailure.unableToReschedule([String? message]) = _UnableToReschedule;
  const factory ScheduledAlertFailure.maxLimitReached([String? message]) = _MaxLimitReached;
  const factory ScheduledAlertFailure.notFound([String? message]) = _NotFound;
  const factory ScheduledAlertFailure.serverError([String? message]) = _ServerError;
}
