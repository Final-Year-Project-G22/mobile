import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/l10n/generated/app_localizations.dart';

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
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    if (state.calendar.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calendar_today,
                size: 48, color: colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(l10n.noUpcomingDeadlines,
                style: theme.textTheme.bodyLarge),
            const SizedBox(height: 8),
            Text(
              l10n.complianceAddEntriesDesc,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.tonal(
              onPressed: () => context.push('/compliance/manage'),
              child: Text(l10n.manageCompliance),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Text(l10n.upcoming,
                    style: theme.textTheme.titleSmall),
                const Spacer(),
                TextButton(
                  onPressed: () => context.push('/compliance/manage'),
                  child: Text(l10n.manage),
                ),
              ],
            ),
          ),
          if (state.calendar.any((e) => e.type == 'compliance')) ...[
            ...state.calendar
                .where((e) => e.type == 'compliance')
                .map((e) => CalendarEntryTile(entry: e)),
          ],
          if (state.calendar.any((e) => e.type == 'scheduled_alert')) ...[
            const Divider(height: 32),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                l10n.scheduledAlerts,
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
    final l10n = AppLocalizations.of(context);
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
              l10n.remaining,
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
