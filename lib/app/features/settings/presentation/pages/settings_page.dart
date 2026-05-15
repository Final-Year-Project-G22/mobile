import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/app_providers.dart';
import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../router/routes.dart';
import '../../../auth/application/auth_notifier.dart';
import '../../../business_profile/application/business_profile_notifier.dart';
import '../../../payment/application/providers/subscription_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final businessProfileAsync = ref.watch(businessProfileProvider);
    final subAsync = ref.watch(subscriptionProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.language, style: theme.textTheme.titleMedium),
          RadioGroup<Locale?>(
            groupValue: locale,
            onChanged: (value) =>
                ref.read(localeProvider.notifier).setLocale(value),
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
          const SizedBox(height: 24),
          Text(l10n.theme, style: theme.textTheme.titleMedium),
          RadioGroup<ThemeMode>(
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
          const SizedBox(height: 24),
          if (businessProfileAsync.hasValue &&
              businessProfileAsync.value == null)
            ListTile(
              leading: const Icon(Icons.business_center_outlined),
              title: Text(l10n.completeBusinessProfile),
              subtitle: Text(l10n.continueOnboardingAnytime),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => const OnboardingRoute().go(context),
            ),
          const SizedBox(height: 24),
          Text(l10n.plan, style: theme.textTheme.titleMedium),
          subAsync.when(
            data: (sub) => ListTile(
              leading: Icon(
                sub?.planName == 'Pro'
                    ? Icons.workspace_premium
                    : Icons.account_circle,
                color: sub?.planName == 'Pro' ? Colors.amber : null,
              ),
              title: Text(sub?.planName == 'Pro' ? l10n.pro : l10n.basic),
              subtitle: sub != null && sub.status == 'active'
                  ? Text(
                      l10n.activeUntil(
                        sub.currentPeriodEnd.toLocal().toString().split(' ')[0],
                      ),
                    )
                  : Text(l10n.freePlan),
              trailing: sub?.planName == 'Pro'
                  ? Chip(
                      label: Text(
                        l10n.pro,
                        style: const TextStyle(fontSize: 10),
                      ),
                      backgroundColor: Colors.amber.shade100,
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    )
                  : const Icon(Icons.chevron_right),
              onTap: () => context.push(const PlansRoute().location),
            ),
            loading: () => ListTile(
              leading: const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
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
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _handleLogout(context, ref),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              foregroundColor: theme.colorScheme.onError,
            ),
            child: Text(l10n.logout),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    await ref.read(authProvider.notifier).logout();
    if (context.mounted) context.go('/login');
  }
}
