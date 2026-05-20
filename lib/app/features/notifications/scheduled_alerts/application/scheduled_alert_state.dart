import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/entities/scheduled_alert.dart';
import '../domain/entities/scheduled_alert_template.dart';
import '../domain/failures/scheduled_alert_failure.dart';

part 'scheduled_alert_state.freezed.dart';

@freezed
abstract class ScheduledAlertState with _$ScheduledAlertState {
  const factory ScheduledAlertState({
    @Default([]) List<ScheduledAlert> alerts,
    @Default([]) List<ScheduledAlertTemplate> templates,
    @Default(false) bool isLoading,
    ScheduledAlertFailure? failure,
    String? success,
  }) = _ScheduledAlertState;

  factory ScheduledAlertState.initial() => const ScheduledAlertState();
}
