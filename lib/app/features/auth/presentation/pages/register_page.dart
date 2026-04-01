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

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _usernameController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _usernameController = TextEditingController();
    unawaited(
      Future.microtask(() {
        ref.read(registerFormProvider.notifier).reset();
        unawaited(ref.read(authProvider.notifier).loadOAuthProviders());
      }),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(registerFormProvider);
    final oauthState = ref.watch(authOAuthStateProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ref
      ..listen(authProvider, (previous, next) {
        next.whenOrNull(
          data: (status) {
            if (!mounted) return;
            if (status.isPendingVerification) {
              const OtpVerificationRoute().go(context);
            } else if (status.isAuthenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Registration successful'),
                  backgroundColor: AppColors.success,
                ),
              );
            }
          },
          error: (error, _) {
            if (error is AuthUserFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    error.maybeWhen(
                      networkError: (_) => 'No internet connection',
                      emailAlreadyInUse: (message) => message ?? 'Email already in use',
                      invalidEmailAndPasswordCombination: (message) =>
                          message ?? 'Invalid email and password combination',
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
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppSpacing.xxl),
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      ),
                    ),
                    AppSpacing.gapVerticalXs,
                    Text(
                      'Sign up to get started',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    AuthTextField(
                      label: 'First Name',
                      hint: 'Enter your first name',
                      controller: _firstNameController,
                      onChanged: (value) {
                        ref.read(registerFormProvider.notifier).firstNameChanged(value);
                      },
                      errorText: formState.showErrorMessages ? formState.firstNameFailure?.toMessage() : null,
                      textCapitalization: TextCapitalization.words,
                    ),
                    AppSpacing.gapLg,
                    AuthTextField(
                      label: 'Last Name',
                      hint: 'Enter your last name',
                      controller: _lastNameController,
                      onChanged: (value) {
                        ref.read(registerFormProvider.notifier).lastNameChanged(value);
                      },
                      errorText: formState.showErrorMessages ? formState.lastNameFailure?.toMessage() : null,
                      textCapitalization: TextCapitalization.words,
                    ),
                    AppSpacing.gapLg,
                    AuthTextField(
                      label: 'Email',
                      hint: 'Enter your email',
                      controller: _emailController,
                      onChanged: (value) {
                        ref.read(registerFormProvider.notifier).emailChanged(value);
                      },
                      errorText: formState.showErrorMessages ? formState.emailFailure?.toMessage() : null,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    AppSpacing.gapLg,
                    AuthTextField(
                      label: 'Username (optional)',
                      hint: 'Choose a username',
                      controller: _usernameController,
                      onChanged: (value) {
                        ref.read(registerFormProvider.notifier).usernameChanged(value);
                      },
                      errorText: formState.showErrorMessages ? formState.usernameFailure?.toMessage() : null,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    AppSpacing.gapLg,
                    AuthTextField(
                      label: 'Password',
                      hint: 'Enter your password',
                      controller: _passwordController,
                      onChanged: (value) {
                        ref.read(registerFormProvider.notifier).passwordChanged(value);
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
                      text: 'Register',
                      isLoading: formState.isSubmitting,
                      onPressed: () {
                        unawaited(
                          ref.read(registerFormProvider.notifier).submit(),
                        );
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
                          'Already have an account? ',
                          style: TextStyle(
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => const LoginRoute().go(context),
                          child: const Text(
                            'Sign In',
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
          if (oauthState.oauthInProgress)
            const Positioned.fill(
              child: ColoredBox(
                color: Colors.black54,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
