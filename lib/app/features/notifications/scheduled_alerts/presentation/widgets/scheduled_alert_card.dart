import 'package:flutter/material.dart';

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

    final (Color dotColor, String statusLabel) = switch (alert.status) {
      'pending' => (Colors.green, 'Pending'),
      'sent' => (Colors.grey, 'Sent'),
      'cancelled' => (Colors.red, 'Cancelled'),
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
                      child: const Text('Reschedule'),
                    ),
                  if (onCancel != null)
                    TextButton(
                      onPressed: onCancel,
                      style: TextButton.styleFrom(
                        foregroundColor: colorScheme.error,
                      ),
                      child: const Text('Cancel'),
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
            Row(
              children: [
                _InfoChip(label: statusLabel, color: dotColor),
                const SizedBox(width: 8),
                ...alert.channels.map(
                  (ch) => Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: _InfoChip(
                      label: _channelLabel(ch),
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  _formatDate(alert.scheduledFor),
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

  String _channelLabel(String channel) {
    return switch (channel) {
      'in_app' => 'In-App',
      'email' => 'Email',
      'push' => 'Push',
      _ => channel,
    };
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = date.difference(now);
    if (diff.isNegative) {
      return 'Overdue';
    } else if (diff.inDays == 0) {
      return 'Today';
    } else if (diff.inDays == 1) {
      return 'Tomorrow';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days';
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
