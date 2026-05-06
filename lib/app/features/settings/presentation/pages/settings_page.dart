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
          RadioListTile<Locale?>(
            title: const Text('English'),
            value: const Locale('en'),
            groupValue: locale,
            onChanged: (value) =>
                ref.read(localeProvider.notifier).setLocale(value),
          ),
          RadioListTile<Locale?>(
            title: const Text('አማርኛ'),
            value: const Locale('am'),
            groupValue: locale,
            onChanged: (value) =>
                ref.read(localeProvider.notifier).setLocale(value),
          ),
          const SizedBox(height: 24),
          Text('Theme', style: theme.textTheme.titleMedium),
          RadioListTile<ThemeMode>(
            title: const Text('Light'),
            value: ThemeMode.light,
            groupValue: themeMode,
            onChanged: (value) =>
                ref.read(themeModeProvider.notifier).setThemeMode(value!),
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Dark'),
            value: ThemeMode.dark,
            groupValue: themeMode,
            onChanged: (value) =>
                ref.read(themeModeProvider.notifier).setThemeMode(value!),
          ),
          RadioListTile<ThemeMode>(
            title: const Text('System'),
            value: ThemeMode.system,
            groupValue: themeMode,
            onChanged: (value) =>
                ref.read(themeModeProvider.notifier).setThemeMode(value!),
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
