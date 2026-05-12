import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/app_colors.dart';
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
    final oauthState = ref.watch(authOAuthStateProvider);
    final pending = oauthState.pendingOAuthEmail;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ref
      ..listen(authProvider, (previous, next) {
        next.whenOrNull(
          error: (error, _) {
            if (error is! AuthUserFailure) {
              return;
            }

            final message = error.maybeWhen(
              networkError: (_) => 'No internet connection',
              oauthCallbackInvalid: (value) =>
                  value ?? 'Invalid OAuth callback',
              oauthStateInvalidOrExpired: (value) =>
                  value ?? 'OAuth session expired, try again',
              serverError: (value) => value ?? 'Server error',
              orElse: () => 'Unable to complete OAuth login',
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: AppColors.error,
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
          networkError: (_) => 'No internet connection',
          oauthCallbackInvalid: (value) => value ?? 'Invalid OAuth callback',
          oauthStateInvalidOrExpired: (value) =>
              value ?? 'OAuth session expired, try again',
          oauthProviderUnavailable: (value) =>
              value ?? 'OAuth provider is unavailable',
          unsupportedOAuthProvider: (value) =>
              value ?? 'Unsupported OAuth provider',
          oauthCancelled: (value) => value ?? 'OAuth login was cancelled',
          serverError: (value) => value ?? 'Server error',
          orElse: () => 'Unable to complete OAuth login',
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: AppColors.error),
        );
      });

    if (pending == null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('No OAuth email completion request found.'),
                const SizedBox(height: AppSpacing.md),
                AuthButton(
                  text: 'Back to Login',
                  onPressed: () => const LoginRoute().go(context),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Complete your sign in',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                ),
              ),
              AppSpacing.gapVerticalXs,
              Text(
                'Add an email to finish signing in with ${pending.provider}.',
                style: TextStyle(
                  fontSize: 16,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.surfaceDark
                      : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  border: Border.all(
                    color: isDark
                        ? AppColors.borderDark
                        : AppColors.borderLight,
                  ),
                ),
                child: Text(
                  pending.name.isNotEmpty
                      ? 'Signed in as ${pending.name}'
                      : 'Provider subject: ${pending.subject}',
                  style: TextStyle(
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              AuthTextField(
                label: 'Email',
                hint: 'Enter your email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: AppSpacing.lg),
              AuthButton(
                text: 'Continue',
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
