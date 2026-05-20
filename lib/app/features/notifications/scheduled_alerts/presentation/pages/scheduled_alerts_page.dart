import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/l10n/generated/app_localizations.dart';
import '../../application/scheduled_alert_notifier.dart';
import '../../application/scheduled_alert_state.dart';
import '../../domain/failures/scheduled_alert_failure.dart';
import '../widgets/scheduled_alert_card.dart';

class ScheduledAlertsPage extends ConsumerStatefulWidget {
  const ScheduledAlertsPage({super.key});

  @override
  ConsumerState<ScheduledAlertsPage> createState() =>
      _ScheduledAlertsPageState();
}

class _ScheduledAlertsPageState extends ConsumerState<ScheduledAlertsPage> {
  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(scheduledAlertProvider);
    final state = asyncState.value ?? ScheduledAlertState.initial();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    ref.listen(scheduledAlertProvider, (previous, next) {
      final failure = next.value?.failure;
      final prevFailure = previous?.value?.failure;
      if (failure != null && failure != prevFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              failure.when(
                serverError: (_) => l10n.errorServer,
                unableToCreate: (_) => l10n.unableToCreateAlert,
                unableToCancel: (_) => l10n.unableToCancelAlert,
                unableToReschedule: (_) => l10n.unableToRescheduleAlert,
                maxLimitReached: (_) => l10n.maxLimitReached,
                notFound: (_) => l10n.scheduledAlertNotFound,
              ),
            ),
            backgroundColor: colorScheme.error,
          ),
        );
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          if (asyncState.isLoading && state.alerts.isEmpty)
            const Center(child: CircularProgressIndicator())
          else if (state.alerts.isEmpty)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.notifications_off,
                      size: 48, color: colorScheme.onSurfaceVariant),
                  const SizedBox(height: 16),
                  Text(
                    l10n.noScheduledAlerts,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.tapToCreate,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            )
          else
            RefreshIndicator(
              onRefresh: () async => ref.refresh(scheduledAlertProvider),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 80),
                itemCount: state.alerts.length,
                itemBuilder: (context, index) {
                  final alert = state.alerts[index];
                  return ScheduledAlertCard(
                    alert: alert,
                    onCancel: alert.status == 'pending'
                        ? () => ref
                            .read(scheduledAlertProvider.notifier)
                            .cancelAlert(alert.id)
                        : null,
                    onReschedule: alert.status == 'pending'
                        ? () => _showRescheduleDialog(alert.id)
                        : null,
                  );
                },
              ),
            ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () => context.push('/scheduled/create'),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showRescheduleDialog(String id) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        DateTime.now().add(const Duration(hours: 1)),
      ),
    );
    if (time == null) return;

    final newDate = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    await ref
        .read(scheduledAlertProvider.notifier)
        .rescheduleAlert(id, newDate);
  }
}
