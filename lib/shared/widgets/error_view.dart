import 'package:flutter/material.dart';

import '../../app/constants/app_spacing.dart';

/// Error view that can be used inline or full-screen with a retry action.
///
/// Use [ErrorView.inline] for embedding within a page alongside other content.
/// Use [ErrorView] directly for full-screen error states.
class ErrorView extends StatelessWidget {
  const ErrorView({
    required this.message,
    this.onRetry,
    this.icon = Icons.error_outline,
    this.retryLabel = 'Retry',
    this.fullScreen = true,
    super.key,
  });

  /// Compact inline variant for embedding within existing layouts.
  const factory ErrorView.inline({
    required String message,
    VoidCallback? onRetry,
    String retryLabel,
    Key? key,
  }) = _InlineErrorView;

  /// Error message to display.
  final String message;

  /// Callback when retry is tapped. If null, no button is shown.
  final VoidCallback? onRetry;

  /// Icon to show above the message.
  final IconData icon;

  /// Retry button label text.
  /// NOTE: Default value is 'Retry' which cannot use AppLocalizations
  /// because it is a const constructor default. Callers should pass l10n.retry.
  final String retryLabel;

  /// Whether to center and expand to fill available space.
  final bool fullScreen;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: colorScheme.errorContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 32, color: colorScheme.onErrorContainer),
        ),
        AppSpacing.gapVerticalMd,
        Text(
          message,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        if (onRetry != null) ...[
          AppSpacing.gapVerticalMd,
          OutlinedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh, size: 18),
            label: Text(retryLabel),
          ),
        ],
      ],
    );

    if (fullScreen) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: content,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenH,
        vertical: AppSpacing.md,
      ),
      child: content,
    );
  }
}

class _InlineErrorView extends ErrorView {
  const _InlineErrorView({
    required super.message,
    super.onRetry,
    super.retryLabel = 'Retry',
    super.key,
  }) : super(fullScreen: false, icon: Icons.warning_amber_rounded);
}
