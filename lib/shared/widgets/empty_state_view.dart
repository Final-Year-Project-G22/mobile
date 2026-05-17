import 'package:flutter/material.dart';

import '../../app/constants/app_spacing.dart';

/// Centralized empty state view with icon, title, description, and optional CTA.
///
/// ```dart
/// EmptyStateView(
///   icon: Icons.forum_outlined,
///   title: 'No Discussions Yet',
///   description: 'Start a new discussion to connect with other entrepreneurs.',
///   actionLabel: 'New Discussion',
///   onAction: () => ...,
/// )
/// ```
class EmptyStateView extends StatelessWidget {
  const EmptyStateView({
    required this.icon,
    required this.title,
    this.description,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  /// Large icon displayed at the center.
  final IconData icon;

  /// Primary message.
  final String title;

  /// Optional explanatory text.
  final String? description;

  /// Optional CTA button label.
  final String? actionLabel;

  /// Callback for the CTA button.
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.xxl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHigh,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            AppSpacing.gapVerticalLg,
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            if (description != null) ...[
              AppSpacing.gapVerticalXs,
              Text(
                description!,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              AppSpacing.gapVerticalLg,
              FilledButton.tonal(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
