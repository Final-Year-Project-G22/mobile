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
          Text('Language', style: theme.textTheme.titleMedium),
          RadioGroup<Locale?>(
            groupValue: locale,
            onChanged: (value) =>
                ref.read(localeProvider.notifier).setLocale(value),
            child: const Column(
              children: [
                RadioListTile<Locale?>(
                  title: Text('English'),
                  value: Locale('en'),
                ),
                RadioListTile<Locale?>(
                  title: Text('አማርኛ'),
                  value: Locale('am'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Theme', style: theme.textTheme.titleMedium),
          RadioGroup<ThemeMode>(
            groupValue: themeMode,
            onChanged: (value) =>
                ref.read(themeModeProvider.notifier).setThemeMode(value!),
            child: const Column(
              children: [
                RadioListTile<ThemeMode>(
                  title: Text('Light'),
                  value: ThemeMode.light,
                ),
                RadioListTile<ThemeMode>(
                  title: Text('Dark'),
                  value: ThemeMode.dark,
                ),
                RadioListTile<ThemeMode>(
                  title: Text('System'),
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
              title: const Text('Complete business profile'),
              subtitle: const Text('Continue onboarding anytime'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => const OnboardingRoute().go(context),
            ),
          const SizedBox(height: 24),
          Text('Plan', style: theme.textTheme.titleMedium),
          subAsync.when(
            data: (sub) => ListTile(
              leading: Icon(
                sub?.planName == 'Pro'
                    ? Icons.workspace_premium
                    : Icons.account_circle,
                color: sub?.planName == 'Pro' ? Colors.amber : null,
              ),
              title: Text(sub?.planName == 'Pro' ? 'Pro' : 'Basic'),
              subtitle: sub != null && sub.status == 'active'
                  ? Text(
                      'Active until ${sub.currentPeriodEnd.toLocal().toString().split(' ')[0]}',
                    )
                  : const Text('Free plan'),
              trailing: sub?.planName == 'Pro'
                  ? Chip(
                      label: const Text('Pro', style: TextStyle(fontSize: 10)),
                      backgroundColor: Colors.amber.shade100,
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                    )
                  : const Icon(Icons.chevron_right),
              onTap: () => context.push(const PlansRoute().location),
            ),
            loading: () => const ListTile(
              leading: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              title: Text('Loading...'),
            ),
            error: (_, _) => ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Basic'),
              subtitle: const Text('Free plan'),
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
            child: const Text('Logout'),
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
