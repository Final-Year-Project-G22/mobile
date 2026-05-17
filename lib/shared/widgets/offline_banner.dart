import 'package:flutter/material.dart';

import '../../app/constants/app_spacing.dart';
import '../../core/l10n/generated/app_localizations.dart';

/// Top banner signaling no-connectivity state.
///
/// Animates in/out based on [isOffline]. Place at the top of the body
/// inside a Column or Stack.
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({
    required this.isOffline,
    this.message,
    super.key,
  });

  /// Whether the banner should be visible.
  final bool isOffline;

  /// Message to display. Defaults to l10n.noInternetConnection.
  final String? message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AnimatedSlide(
      offset: isOffline ? Offset.zero : const Offset(0, -1),
      duration: AppSpacing.durationMedium2,
      curve: AppSpacing.curveEaseOut,
      child: AnimatedOpacity(
        opacity: isOffline ? 1.0 : 0.0,
        duration: AppSpacing.durationMedium1,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          color: colorScheme.tertiary,
          child: SafeArea(
            bottom: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off,
                  size: 16,
                  color: colorScheme.onTertiary,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  message ?? l10n.noInternetConnection,
                  style: textTheme.labelMedium?.copyWith(
                    color: colorScheme.onTertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
