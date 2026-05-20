import 'package:flutter/material.dart';

import '../../../../../../core/l10n/generated/app_localizations.dart';
import '../../domain/entities/scheduled_alert.dart';

class ScheduledAlertCard extends StatelessWidget {
  const ScheduledAlertCard({
    required this.alert,
    this.onCancel,
    this.onReschedule,
    super.key,
  });

  final ScheduledAlert alert;
  final VoidCallback? onCancel;
  final VoidCallback? onReschedule;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    final (Color dotColor, String statusLabel) = switch (alert.status) {
      'pending' => (Colors.green, l10n.pending),
      'sent' => (Colors.grey, l10n.sent),
      'cancelled' => (Colors.red, l10n.cancelledStatus),
      _ => (Colors.grey, alert.status),
    };

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    alert.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      decoration: alert.status == 'cancelled'
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),
                if (alert.status == 'pending') ...[
                  if (onReschedule != null)
                    TextButton(
                      onPressed: onReschedule,
                      child: Text(l10n.reschedule),
                    ),
                  if (onCancel != null)
                    TextButton(
                      onPressed: onCancel,
                      style: TextButton.styleFrom(
                        foregroundColor: colorScheme.error,
                      ),
                      child: Text(l10n.cancel),
                    ),
                ],
              ],
            ),
            const SizedBox(height: 4),
            Text(
              alert.body,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _InfoChip(label: statusLabel, color: dotColor),
                ...alert.channels.map(
                  (ch) => _InfoChip(
                    label: _channelLabel(l10n, ch),
                    color: colorScheme.primary,
                  ),
                ),
                Text(
                  _formatDate(l10n, alert.scheduledFor),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _channelLabel(AppLocalizations l10n, String channel) {
    return switch (channel) {
      'in_app' => l10n.inAppChannel,
      'email' => l10n.email,
      'push' => l10n.pushChannel,
      _ => channel,
    };
  }

  String _formatDate(AppLocalizations l10n, DateTime date) {
    final now = DateTime.now();
    final diff = date.difference(now);
    if (diff.isNegative) {
      return l10n.overdue;
    } else if (diff.inDays == 0) {
      return l10n.today;
    } else if (diff.inDays == 1) {
      return l10n.tomorrow;
    } else if (diff.inDays < 7) {
      return '${diff.inDays} ${l10n.remaining}';
    }
    return '${date.month}/${date.day}';
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, color: color),
      ),
    );
  }
}
