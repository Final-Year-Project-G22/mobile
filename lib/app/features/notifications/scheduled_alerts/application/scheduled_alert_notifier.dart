import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/di/notification_providers.dart';
import '../domain/entities/scheduled_alert.dart';
import '../domain/entities/scheduled_alert_template.dart';
import '../domain/failures/scheduled_alert_failure.dart';
import 'scheduled_alert_state.dart';

part 'scheduled_alert_notifier.g.dart';

@riverpod
class ScheduledAlertNotifier extends _$ScheduledAlertNotifier {
  @override
  Future<ScheduledAlertState> build() async {
    final repository = ref.read(scheduledAlertRepositoryProvider);
    final results = await Future.wait([
      repository.list(),
      repository.listTemplates(),
    ]);
    final alerts = results[0] as Either<ScheduledAlertFailure, List<ScheduledAlert>>;
    final templates = results[1] as Either<ScheduledAlertFailure, List<ScheduledAlertTemplate>>;
    return ScheduledAlertState.initial().copyWith(
      alerts: alerts.getOrElse(() => []),
      templates: templates.getOrElse(() => []),
    );
  }

  Future<void> createAlert({
    required String? templateSlug,
    required String title,
    required String body,
    required List<String> channels,
    required DateTime scheduledFor,
  }) async {
    final repository = ref.read(scheduledAlertRepositoryProvider);
    final result = await repository.create(
      templateSlug: templateSlug,
      title: title,
      body: body,
      channels: channels,
      scheduledFor: scheduledFor,
    );
    result.fold(
      (failure) {
        state = AsyncValue.data(
          state.value!.copyWith(errorMessage: _mapFailure(failure)),
        );
      },
      (_) {
        ref.invalidateSelf();
      },
    );
  }

  Future<void> cancelAlert(String id) async {
    final repository = ref.read(scheduledAlertRepositoryProvider);
    final result = await repository.cancel(id);
    result.fold(
      (failure) {
        state = AsyncValue.data(
          state.value!.copyWith(errorMessage: _mapFailure(failure)),
        );
      },
      (_) {
        ref.invalidateSelf();
      },
    );
  }

  Future<void> rescheduleAlert(String id, DateTime newDate) async {
    final repository = ref.read(scheduledAlertRepositoryProvider);
    final result = await repository.reschedule(id, newScheduledFor: newDate);
    result.fold(
      (failure) {
        state = AsyncValue.data(
          state.value!.copyWith(errorMessage: _mapFailure(failure)),
        );
      },
      (_) {
        ref.invalidateSelf();
      },
    );
  }

  Future<void> loadTemplates() async {
    final repository = ref.read(scheduledAlertRepositoryProvider);
    final result = await repository.listTemplates();
    result.fold(
      (failure) {},
      (templates) {
        if (state.hasValue) {
          state = AsyncValue.data(
            state.value!.copyWith(templates: templates),
          );
        }
      },
    );
  }

  String _mapFailure(ScheduledAlertFailure failure) {
    return failure.when(
      unableToCreate: (msg) => msg ?? 'Unable to create alert',
      unableToCancel: (msg) => msg ?? 'Unable to cancel alert',
      unableToReschedule: (msg) => msg ?? 'Unable to reschedule alert',
      maxLimitReached: (msg) =>
          msg ?? 'Upgrade to Pro to create more than 3 scheduled alerts',
      notFound: (msg) => msg ?? 'Scheduled alert not found',
      serverError: (msg) => msg ?? 'Server error. Please try again.',
    );
  }
}
