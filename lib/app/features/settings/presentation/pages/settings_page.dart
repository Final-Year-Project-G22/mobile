import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/di/app_providers.dart';
import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../auth/application/auth_notifier.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Language', style: theme.textTheme.titleMedium),
          RadioGroup<Locale?>(
            groupValue: locale,
            onChanged: (value) => ref.read(localeProvider.notifier).setLocale(value),
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
            onChanged: (value) => ref.read(themeModeProvider.notifier).setThemeMode(value!),
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
          const SizedBox(height: 48),
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
