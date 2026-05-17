import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/constants/app_spacing.dart';
import '../di/app_providers.dart';
import '../l10n/generated/app_localizations.dart';

class LocaleToggleButton extends ConsumerWidget {
  const LocaleToggleButton({super.key});

  String _labelFor(Locale? locale) {
    if (locale == null) return 'AUTO';
    if (locale.languageCode == 'am') return 'አማ';
    return 'EN';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return PopupMenuButton<Locale?>(
      onSelected: (value) => ref.read(localeProvider.notifier).setLocale(value),
      offset: const Offset(0, 40),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: const Locale('en'),
          child: Text(l10n.languageEnglish),
        ),
        PopupMenuItem(
          value: const Locale('am'),
          child: Text(l10n.languageAmharic),
        ),
        PopupMenuItem(
          child: Text(l10n.systemDefault),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          color: theme.colorScheme.surface.withValues(alpha: 0.8),
        ),
        child: Text(
          _labelFor(locale),
          style: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
