import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/scheduled_alert_notifier.dart';
import '../../application/scheduled_alert_state.dart';
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

    ref.listen(scheduledAlertProvider, (previous, next) {
      final nextErr = next.value?.errorMessage;
      final prevErr = previous?.value?.errorMessage;
      if (nextErr != null && nextErr != prevErr) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(nextErr)));
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
                    'No scheduled alerts yet',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to create one',
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
