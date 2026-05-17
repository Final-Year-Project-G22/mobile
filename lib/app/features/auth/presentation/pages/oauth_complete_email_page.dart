import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../router/routes.dart';
import '../../application/auth_notifier.dart';
import '../../application/auth_oauth_state.dart';
import '../../domain/failures/auth_user_failure.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';

class OAuthCompleteEmailPage extends ConsumerStatefulWidget {
  const OAuthCompleteEmailPage({super.key});

  @override
  ConsumerState<OAuthCompleteEmailPage> createState() =>
      _OAuthCompleteEmailPageState();
}

class _OAuthCompleteEmailPageState
    extends ConsumerState<OAuthCompleteEmailPage> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final oauthState = ref.watch(authOAuthStateProvider);
    final pending = oauthState.pendingOAuthEmail;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    ref
      ..listen(authProvider, (previous, next) {
        next.whenOrNull(
          error: (error, _) {
            if (error is! AuthUserFailure) {
              return;
            }

            final message = error.maybeWhen(
              networkError: (_) => l10n.errorNetwork,
              oauthCallbackInvalid: (value) =>
                  value ?? l10n.errorOAuthCallbackInvalid,
              oauthStateInvalidOrExpired: (value) =>
                  value ?? l10n.errorOAuthExpired,
              serverError: (value) => value ?? l10n.errorServer,
              orElse: () => l10n.errorGeneric,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: colorScheme.error,
              ),
            );
          },
        );
      })
      ..listen(authOAuthStateProvider, (previous, next) {
        if (next.oauthProvidersFailure == null ||
            previous?.oauthProvidersFailure == next.oauthProvidersFailure) {
          return;
        }

        final message = next.oauthProvidersFailure!.maybeWhen(
          networkError: (_) => l10n.errorNetwork,
          oauthCallbackInvalid: (value) =>
              value ?? l10n.errorOAuthCallbackInvalid,
          oauthStateInvalidOrExpired: (value) =>
              value ?? l10n.errorOAuthExpired,
          oauthProviderUnavailable: (value) =>
              value ?? l10n.errorOAuthUnavailable,
          unsupportedOAuthProvider: (value) =>
              value ?? l10n.errorOAuthUnsupported,
          oauthCancelled: (value) => value ?? l10n.errorOAuthCancelled,
          serverError: (value) => value ?? l10n.errorServer,
          orElse: () => l10n.errorGeneric,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: colorScheme.error),
        );
      });

    if (pending == null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.screenH),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.oAuthNoCompletionRequest,
                  style: textTheme.bodyLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                AuthButton(
                  text: l10n.oAuthBackToLogin,
                  onPressed: () => const LoginRoute().go(context),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.screenH),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xl),
              Text(
                l10n.oAuthCompletionTitle,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              AppSpacing.gapVerticalXs,
              Text(
                l10n.oAuthCompletionSubtitle(pending.provider),
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  border: Border.all(
                    color: colorScheme.outlineVariant,
                  ),
                ),
                child: Text(
                  pending.name.isNotEmpty
                      ? l10n.oAuthCompletionSignedInAs(pending.name)
                      : l10n.oAuthCompletionProviderSubject(pending.subject),
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              AuthTextField(
                label: l10n.email,
                hint: l10n.emailHint,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: AppSpacing.lg),
              AuthButton(
                text: l10n.continueText,
                isLoading: oauthState.oauthInProgress,
                onPressed: () {
                  unawaited(
                    ref
                        .read(authProvider.notifier)
                        .completeOAuthEmail(
                          email: _emailController.text.trim(),
                          state: pending.state,
                        ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
