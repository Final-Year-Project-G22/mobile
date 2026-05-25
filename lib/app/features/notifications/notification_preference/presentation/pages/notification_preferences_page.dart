import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../../shared/widgets/adisu_progress_indicator.dart';
import '../../../../../constants/app_spacing.dart';
import '../../application/notification_preference_notifier.dart';

class NotificationPreferencesPage extends ConsumerWidget {
  const NotificationPreferencesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final stateAsync = ref.watch(notificationPreferenceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.notificationPreferences),
      ),
      body: stateAsync.when(
        loading: () => const Center(child: AdisuProgressIndicator.small()),
        error: (error, _) => Center(
          child: Padding(
            padding: AppSpacing.paddingLg,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: colorScheme.error),
                AppSpacing.gapVerticalMd,
                Text(
                  l10n.error,
                  style: TextStyle(color: colorScheme.error),
                  textAlign: TextAlign.center,
                ),
                AppSpacing.gapVerticalLg,
                FilledButton(
                  onPressed: () =>
                      ref.invalidate(notificationPreferenceProvider),
                  child: Text(l10n.retry),
                ),
              ],
            ),
          ),
        ),
        data: (state) {
          final pref = state.preference;
          final notifier = ref.read(notificationPreferenceProvider.notifier);

          if (state.failure != null && pref == null) {
            return Center(
              child: Padding(
                padding: AppSpacing.paddingLg,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,
                        size: 48, color: colorScheme.error),
                    AppSpacing.gapVerticalMd,
                    Text(
                      l10n.error,
                      style: TextStyle(color: colorScheme.error),
                      textAlign: TextAlign.center,
                    ),
                    AppSpacing.gapVerticalLg,
                    FilledButton(
                      onPressed: () =>
                          ref.invalidate(notificationPreferenceProvider),
                      child: Text(l10n.retry),
                    ),
                  ],
                ),
              ),
            );
          }

          if (pref == null) {
            return const Center(child: AdisuProgressIndicator.small());
          }

          return ListView(
            padding: AppSpacing.paddingLg,
            children: [
              Card(
                margin: EdgeInsets.zero,
                  child: SwitchListTile(
                  value: true,
                  onChanged: null,
                  title: Text(l10n.inAppAlwaysOn),
                  secondary: Icon(Icons.notifications,
                      color: colorScheme.primary),
                  activeTrackColor: colorScheme.secondary,
                  activeThumbColor: colorScheme.onSecondary,
                  inactiveTrackColor: colorScheme.surfaceContainerHighest,
                  inactiveThumbColor: colorScheme.onSurfaceVariant,
                ),
              ),
              AppSpacing.gapVerticalSm,
              Card(
                margin: EdgeInsets.zero,
                child: SwitchListTile(
                  value: pref.emailEnabled,
                  onChanged: (value) => notifier.updatePreferences(
                    emailEnabled: value,
                    pushEnabled: pref.pushEnabled,
                  ),
                  title: Text(l10n.emailNotifications),
                  secondary: Icon(Icons.email_outlined,
                      color: colorScheme.primary),
                  activeTrackColor: colorScheme.secondary,
                  activeThumbColor: colorScheme.onSecondary,
                  inactiveTrackColor: colorScheme.surfaceContainerHighest,
                  inactiveThumbColor: colorScheme.onSurfaceVariant,
                ),
              ),
              AppSpacing.gapVerticalSm,
              Card(
                margin: EdgeInsets.zero,
                child: SwitchListTile(
                  value: pref.pushEnabled,
                  onChanged: (value) => notifier.updatePreferences(
                    emailEnabled: pref.emailEnabled,
                    pushEnabled: value,
                  ),
                  title: Text(l10n.pushNotifications),
                  secondary: Icon(Icons.phone_android_outlined,
                      color: colorScheme.primary),
                  activeTrackColor: colorScheme.secondary,
                  activeThumbColor: colorScheme.onSecondary,
                  inactiveTrackColor: colorScheme.surfaceContainerHighest,
                  inactiveThumbColor: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
