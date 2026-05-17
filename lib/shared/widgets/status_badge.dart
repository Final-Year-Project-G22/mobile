import 'package:flutter/material.dart';

import '../../app/constants/app_spacing.dart';

/// M3-compliant status badge with triple redundancy: color + icon + text.
///
/// Covers four statuses: completed, inProgress, notStarted, urgent.
enum StatusType { completed, inProgress, notStarted, urgent }

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    required this.status,
    this.label,
    this.compact = false,
    super.key,
  });

  /// The status to display.
  final StatusType status;

  /// Optional override label. If null, uses a default based on [status].
  final String? label;

  /// When true, shows only the icon (no label).
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final config = _resolveConfig(colorScheme);

    if (compact) {
      return Icon(config.icon, color: config.foreground, size: 20);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: config.background,
        borderRadius: AppSpacing.borderRadiusFull,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(config.icon, color: config.foreground, size: 14),
          const SizedBox(width: 4),
          Text(
            label ?? config.defaultLabel,
            style: textTheme.labelSmall?.copyWith(
              color: config.foreground,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  _StatusConfig _resolveConfig(ColorScheme colorScheme) {
    switch (status) {
      case StatusType.completed:
        return _StatusConfig(
          background: colorScheme.secondaryContainer,
          foreground: colorScheme.onSecondaryContainer,
          icon: Icons.check_circle,
          defaultLabel: 'Completed',
        );
      case StatusType.inProgress:
        return _StatusConfig(
          background: colorScheme.tertiaryContainer,
          foreground: colorScheme.onTertiaryContainer,
          icon: Icons.schedule,
          defaultLabel: 'In Progress',
        );
      case StatusType.notStarted:
        return _StatusConfig(
          background: colorScheme.surfaceContainerHigh,
          foreground: colorScheme.onSurfaceVariant,
          icon: Icons.circle_outlined,
          defaultLabel: 'Not Started',
        );
      case StatusType.urgent:
        return _StatusConfig(
          background: colorScheme.errorContainer,
          foreground: colorScheme.onErrorContainer,
          icon: Icons.warning,
          defaultLabel: 'Urgent',
        );
    }
  }
}

class _StatusConfig {
  const _StatusConfig({
    required this.background,
    required this.foreground,
    required this.icon,
    required this.defaultLabel,
  });

  final Color background;
  final Color foreground;
  final IconData icon;
  final String defaultLabel;
}
