import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/compliance_notifier.dart';
import '../../application/compliance_state.dart';
import '../../domain/entities/calendar_entry.dart';

class CompliancePage extends ConsumerStatefulWidget {
  const CompliancePage({super.key});

  @override
  ConsumerState<CompliancePage> createState() => _CompliancePageState();
}

class _CompliancePageState extends ConsumerState<CompliancePage> {
  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(complianceProvider);
    final state = asyncState.value ?? ComplianceState.initial();
    final theme = Theme.of(context);

    if (state.calendar.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calendar_today,
                size: 48, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text('No upcoming deadlines',
                style: theme.textTheme.bodyLarge),
            const SizedBox(height: 8),
            Text(
              'Add compliance entries from your business profile',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => ref.refresh(complianceProvider),
      child: ListView(
        padding: const EdgeInsets.only(top: 8, bottom: 80),
        children: [
          if (state.calendar.any((e) => e.type == 'compliance')) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                'Upcoming Deadlines',
                style: theme.textTheme.titleSmall,
              ),
            ),
            ...state.calendar
                .where((e) => e.type == 'compliance')
                .map((e) => CalendarEntryTile(entry: e)),
          ],
          if (state.calendar.any((e) => e.type == 'scheduled_alert')) ...[
            const Divider(height: 32),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                'Scheduled Alerts',
                style: theme.textTheme.titleSmall,
              ),
            ),
            ...state.calendar
                .where((e) => e.type == 'scheduled_alert')
                .map((e) => CalendarEntryTile(entry: e)),
          ],
        ],
      ),
    );
  }
}

class CalendarEntryTile extends StatelessWidget {
  const CalendarEntryTile({required this.entry, super.key});

  final CalendarEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUrgent = entry.daysRemaining <= 7;
    final color = isUrgent ? Colors.red : theme.colorScheme.primary;
    final icon = entry.type == 'compliance'
        ? Icons.assignment_late
        : Icons.notifications;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(entry.title, style: theme.textTheme.bodyMedium),
        subtitle: entry.referenceNumber != null
            ? Text(entry.referenceNumber!,
                style: theme.textTheme.bodySmall)
            : null,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${entry.daysRemaining}d',
              style: theme.textTheme.titleSmall?.copyWith(
                color: isUrgent ? Colors.red : null,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'remaining',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
