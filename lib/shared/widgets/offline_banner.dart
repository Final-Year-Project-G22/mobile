import 'package:flutter/material.dart';

import '../../app/constants/app_colors.dart';
import '../../app/constants/app_spacing.dart';

/// Top banner signaling no-connectivity state.
///
/// Animates in/out based on [isOffline]. Place at the top of the body
/// inside a Column or Stack.
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({
    required this.isOffline,
    this.message = 'No internet connection',
    super.key,
  });

  /// Whether the banner should be visible.
  final bool isOffline;

  /// Message to display.
  final String message;

  @override
  Widget build(BuildContext context) {
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
          color: AppColors.warning,
          child: SafeArea(
            bottom: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.wifi_off,
                  size: 16,
                  color: Colors.white,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  message,
                  style: textTheme.labelMedium?.copyWith(
                    color: Colors.white,
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
