import 'package:flutter/material.dart';

import '../../app/constants/app_spacing.dart';

/// Reusable section header with title and optional trailing action.
///
/// ```dart
/// SectionHeader(
///   title: 'Recent Guides',
///   actionLabel: 'See All',
///   onAction: () => ...,
/// )
/// ```
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    this.actionLabel,
    this.onAction,
    this.padding,
    super.key,
  });

  /// Section title text.
  final String title;

  /// Optional trailing button label (e.g. "See All").
  final String? actionLabel;

  /// Callback when the action button is tapped.
  final VoidCallback? onAction;

  /// Override default horizontal padding.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ),
          if (actionLabel != null && onAction != null)
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                actionLabel!,
                style: textTheme.labelLarge?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
