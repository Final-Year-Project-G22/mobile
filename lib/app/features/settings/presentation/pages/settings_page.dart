import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/app_providers.dart';
import '../../../../../core/di/auth_providers.dart';
import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/widgets/adisu_progress_indicator.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../router/routes.dart';
import '../../../auth/application/auth_notifier.dart';
import '../../../business_profile/application/business_profile_notifier.dart';
import '../../../payment/application/providers/subscription_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final businessProfileAsync = ref.watch(businessProfileProvider);
    final subAsync = ref.watch(subscriptionProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: AppSpacing.paddingLg,
        children: [
          Text(
            l10n.language,
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
            ),
          ),
          AppSpacing.gapVerticalSm,
          Card(
            margin: EdgeInsets.zero,
            child:           RadioGroup<Locale?>(
              groupValue: locale,
              onChanged: (value) async {
                ref.read(localeProvider.notifier).setLocale(value);
                if (value != null) {
                  try {
                    final authClient = ref.read(authenticationClientProvider);
                    await authClient.updateAccountPreferences(
                      body: UpdateAccountPreferenceRequest(
                        language: value.languageCode,
                      ),
                    );
                  } on DioException {
                    // Silently ignore — local preference is already set
                  }
                }
              },
              child: Column(
                children: [
                  RadioListTile<Locale?>(
                    title: Text(l10n.languageEnglish),
                    value: const Locale('en'),
                  ),
                  RadioListTile<Locale?>(
                    title: Text(l10n.languageAmharic),
                    value: const Locale('am'),
                  ),
                ],
              ),
            ),
          ),
          AppSpacing.gapVerticalLg,
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: Text(l10n.notificationPreferences),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => const NotificationPreferencesRoute().push<void>(context),
            ),
          ),
          AppSpacing.gapVerticalLg,
          Text(
            l10n.theme,
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
            ),
          ),
          AppSpacing.gapVerticalSm,
          Card(
            margin: EdgeInsets.zero,
            child: RadioGroup<ThemeMode>(
              groupValue: themeMode,
              onChanged: (value) =>
                  ref.read(themeModeProvider.notifier).setThemeMode(value!),
              child: Column(
                children: [
                  RadioListTile<ThemeMode>(
                    title: Text(l10n.lightMode),
                    value: ThemeMode.light,
                  ),
                  RadioListTile<ThemeMode>(
                    title: Text(l10n.darkMode),
                    value: ThemeMode.dark,
                  ),
                  RadioListTile<ThemeMode>(
                    title: Text(l10n.systemDefault),
                    value: ThemeMode.system,
                  ),
                ],
              ),
            ),
          ),
          AppSpacing.gapVerticalLg,
          if (businessProfileAsync.hasValue &&
              businessProfileAsync.value == null) ...[
            Card(
              margin: EdgeInsets.zero,
              color: colorScheme.secondaryContainer,
              child: ListTile(
                leading: Icon(
                  Icons.business_center_outlined,
                  color: colorScheme.onSecondaryContainer,
                ),
                title: Text(
                  l10n.completeBusinessProfile,
                  style: TextStyle(color: colorScheme.onSecondaryContainer),
                ),
                subtitle: Text(
                  l10n.continueOnboardingAnytime,
                  style: TextStyle(
                    color: colorScheme.onSecondaryContainer.withValues(
                      alpha: 0.8,
                    ),
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSecondaryContainer,
                ),
                onTap: () => const OnboardingRoute().go(context),
              ),
            ),
            AppSpacing.gapVerticalLg,
          ],
          Text(
            l10n.plan,
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
            ),
          ),
          AppSpacing.gapVerticalSm,
          Card(
            margin: EdgeInsets.zero,
            child: subAsync.when(
              data: (sub) => ListTile(
                leading: Icon(
                  sub?.planName == 'Pro'
                      ? Icons.workspace_premium
                      : Icons.account_circle,
                  color: sub?.planName == 'Pro' ? colorScheme.tertiary : null,
                ),
                title: Text(sub?.planName == 'Pro' ? l10n.pro : l10n.basic),
                subtitle: sub != null && sub.status == 'active'
                    ? Text(
                        l10n.activeUntil(
                          sub.currentPeriodEnd.toLocal().toString().split(
                            ' ',
                          )[0],
                        ),
                      )
                    : Text(l10n.freePlan),
                trailing: sub?.planName == 'Pro'
                    ? Chip(
                        label: Text(
                          l10n.pro,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontSize: 10,
                          ),
                        ),
                        backgroundColor: colorScheme.tertiaryContainer,
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      )
                    : const Icon(Icons.chevron_right),
                onTap: () => context.push(const PlansRoute().location),
              ),
              loading: () => ListTile(
                leading: const AdisuProgressIndicator.small(),
                title: Text(l10n.loading),
              ),
              error: (_, _) => ListTile(
                leading: const Icon(Icons.account_circle),
                title: Text(l10n.basic),
                subtitle: Text(l10n.freePlan),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(const PlansRoute().location),
              ),
            ),
          ),
          AppSpacing.gapVerticalXxl,
          FilledButton(
            onPressed: () => _handleLogout(context, ref),
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
            ),
            child: Text(l10n.logout),
          ),
          AppSpacing.gapVerticalLg,
        ],
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    await ref.read(authProvider.notifier).logout();
    if (context.mounted) context.go('/login');
  }
}
