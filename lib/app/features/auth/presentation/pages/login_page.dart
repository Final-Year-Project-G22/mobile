import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../router/routes.dart';
import '../../application/auth_form_notifier.dart';
import '../../application/auth_notifier.dart';
import '../../application/auth_oauth_state.dart';
import '../../domain/failures/auth_user_failure.dart';
import '../../domain/failures/auth_value_failure.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/oauth_provider_section.dart';

class LogInPage extends ConsumerStatefulWidget {
  const LogInPage({super.key});

  @override
  ConsumerState<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends ConsumerState<LogInPage> {
  late TextEditingController _identifierController;
  late TextEditingController _passwordController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _identifierController = TextEditingController();
    _passwordController = TextEditingController();
    unawaited(
      Future.microtask(() {
        ref.read(loginFormProvider.notifier).reset();
        unawaited(ref.read(authProvider.notifier).loadOAuthProviders());
      }),
    );
  }

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(loginFormProvider);
    final oauthState = ref.watch(authOAuthStateProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ref
      ..listen(authProvider, (previous, next) {
        next.whenOrNull(
          error: (error, _) {
            if (error is AuthUserFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    error.maybeWhen(
                      networkError: (_) => 'No internet connection',
                      emailAlreadyInUse: (message) => message ?? 'Email already in use',
                      invalidEmailAndPasswordCombination: (message) => message ?? 'Invalid email or password',
                      serverError: (message) => message ?? 'Server error',
                      orElse: () => 'An error occurred',
                    ),
                  ),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
        );
      })
      ..listen(authOAuthStateProvider, (previous, next) {
        if (next.oauthProvidersFailure == null || previous?.oauthProvidersFailure == next.oauthProvidersFailure) {
          return;
        }

        final message = next.oauthProvidersFailure!.maybeWhen(
          networkError: (_) => 'No internet connection',
          oauthProviderUnavailable: (value) => value ?? 'OAuth provider is unavailable',
          oauthCallbackInvalid: (value) => value ?? 'Invalid OAuth callback',
          oauthStateInvalidOrExpired: (value) => value ?? 'OAuth session expired, try again',
          unsupportedOAuthProvider: (value) => value ?? 'Unsupported OAuth provider',
          oauthCancelled: (value) => value ?? 'OAuth login was cancelled',
          serverError: (value) => value ?? 'Server error',
          orElse: () => 'OAuth sign in failed',
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: AppColors.error),
        );
      });

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.xxl),
                Text(
                  'LogIn',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  ),
                ),
                AppSpacing.gapVerticalXs,
                Text(
                  'LogIn to get started',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                AppSpacing.gapLg,
                AuthTextField(
                  label: 'Email or Username',
                  hint: 'Enter your email or username',
                  controller: _identifierController,
                  onChanged: (value) {
                    ref.read(loginFormProvider.notifier).identifierChanged(value);
                  },
                  errorText: formState.showErrorMessages ? formState.identifierFailure?.toMessage() : null,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                AppSpacing.gapLg,
                AuthTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: _passwordController,
                  onChanged: (value) {
                    ref.read(loginFormProvider.notifier).passwordChanged(value);
                  },
                  errorText: formState.showErrorMessages ? formState.passwordFailure?.toMessage() : null,
                  obscureText: _obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                AuthButton(
                  text: 'Login',
                  isLoading: formState.isSubmitting,
                  onPressed: () {
                    unawaited(ref.read(loginFormProvider.notifier).submit());
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                OAuthProviderSection(
                  providers: oauthState.oauthProviders,
                  isLoading: oauthState.isLoadingOAuthProviders,
                  isDisabled: oauthState.oauthInProgress,
                  onProviderTap: (provider) {
                    unawaited(
                      ref.read(authProvider.notifier).startOAuthLogin(provider.name),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => const RegisterRoute().go(context),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
