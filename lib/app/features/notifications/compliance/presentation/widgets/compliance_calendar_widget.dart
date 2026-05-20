import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/l10n/generated/app_localizations.dart';

import '../../../../../../shared/widgets/section_header.dart';
import '../../application/compliance_notifier.dart';
import '../../application/compliance_state.dart';
import '../../domain/entities/calendar_entry.dart';

class ComplianceCalendarWidget extends ConsumerStatefulWidget {
  const ComplianceCalendarWidget({
    this.maxEntries = 3,
    this.onSeeAll,
    this.onEntryTap,
    super.key,
  });

  final int maxEntries;
  final VoidCallback? onSeeAll;
  final void Function(CalendarEntry entry)? onEntryTap;

  @override
  ConsumerState<ComplianceCalendarWidget> createState() =>
      _ComplianceCalendarWidgetState();
}

class _ComplianceCalendarWidgetState
    extends ConsumerState<ComplianceCalendarWidget> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final asyncState = ref.watch(complianceProvider);
    final state = asyncState.value ?? ComplianceState.initial();

    if (state.calendar.isEmpty) return const SizedBox.shrink();

    final entries = state.calendar.take(widget.maxEntries).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: l10n.complianceCalendar,
          actionLabel: l10n.seeAll,
          onAction: widget.onSeeAll,
        ),
        const SizedBox(height: 8),
        ...entries.map((entry) => _CalendarEntryTile(
              entry: entry,
              onTap: widget.onEntryTap != null
                  ? () => widget.onEntryTap!(entry)
                  : null,
            )),
      ],
    );
  }
}

class _CalendarEntryTile extends StatelessWidget {
  const _CalendarEntryTile({required this.entry, this.onTap});

  final CalendarEntry entry;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isUrgent = entry.daysRemaining <= 7;
    final color = isUrgent ? Colors.red : theme.colorScheme.primary;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Icon(
          entry.type == 'compliance'
              ? Icons.assignment_late
              : Icons.notifications,
          color: color,
        ),
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
        onTap: onTap,
      ),
    );
  }
}
