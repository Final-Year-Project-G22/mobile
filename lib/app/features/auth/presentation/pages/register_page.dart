import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../core/widgets/locale_toggle_button.dart';
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
    final l10n = AppLocalizations.of(context);

    ref
      ..listen(authProvider, (previous, next) {
        next.whenOrNull(
          data: (status) {
            if (!mounted) return;
            if (status.isPendingVerification) {
              const OtpVerificationRoute().go(context);
            } else if (status.isAuthenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.registrationSuccessful),
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
                      networkError: (_) => l10n.errorNetwork,
                      emailAlreadyInUse: (message) =>
                          message ?? l10n.errorEmailInUse,
                      invalidEmailAndPasswordCombination: (message) =>
                          message ?? l10n.errorInvalidCredentials,
                      serverError: (message) => message ?? l10n.errorServer,
                      orElse: () => l10n.errorGeneric,
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
        if (next.oauthProvidersFailure == null ||
            previous?.oauthProvidersFailure == next.oauthProvidersFailure) {
          return;
        }

        final message = next.oauthProvidersFailure!.maybeWhen(
          networkError: (_) => l10n.errorNetwork,
          oauthProviderUnavailable: (value) =>
              value ?? l10n.errorOAuthUnavailable,
          oauthCallbackInvalid: (value) =>
              value ?? l10n.errorOAuthCallbackInvalid,
          oauthStateInvalidOrExpired: (value) =>
              value ?? l10n.errorOAuthExpired,
          unsupportedOAuthProvider: (value) =>
              value ?? l10n.errorOAuthUnsupported,
          oauthCancelled: (value) => value ?? l10n.errorOAuthCancelled,
          serverError: (value) => value ?? l10n.errorServer,
          orElse: () => l10n.errorOAuthFailed,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: AppColors.error),
        );
      });

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: Stack(
        children: [
          const Positioned(
            top: 8,
            right: 8,
            child: LocaleToggleButton(),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppSpacing.xxl),
                    Text(
                      l10n.createAccount,
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
                      l10n.registerSubtitle,
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    AuthTextField(
                      label: l10n.firstName,
                      hint: l10n.firstNameHint,
                      controller: _firstNameController,
                      onChanged: (value) {
                        ref
                            .read(registerFormProvider.notifier)
                            .firstNameChanged(value);
                      },
                      errorText: formState.showErrorMessages
                          ? formState.firstNameFailure?.toMessage()
                          : null,
                      textCapitalization: TextCapitalization.words,
                    ),
                    AppSpacing.gapLg,
                    AuthTextField(
                      label: l10n.lastName,
                      hint: l10n.lastNameHint,
                      controller: _lastNameController,
                      onChanged: (value) {
                        ref
                            .read(registerFormProvider.notifier)
                            .lastNameChanged(value);
                      },
                      errorText: formState.showErrorMessages
                          ? formState.lastNameFailure?.toMessage()
                          : null,
                      textCapitalization: TextCapitalization.words,
                    ),
                    AppSpacing.gapLg,
                    AuthTextField(
                      label: l10n.email,
                      hint: l10n.emailHint,
                      controller: _emailController,
                      onChanged: (value) {
                        ref
                            .read(registerFormProvider.notifier)
                            .emailChanged(value);
                      },
                      errorText: formState.showErrorMessages
                          ? formState.emailFailure?.toMessage()
                          : null,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    AppSpacing.gapLg,
                    AuthTextField(
                      label: l10n.username,
                      hint: l10n.usernameHint,
                      controller: _usernameController,
                      onChanged: (value) {
                        ref
                            .read(registerFormProvider.notifier)
                            .usernameChanged(value);
                      },
                      errorText: formState.showErrorMessages
                          ? formState.usernameFailure?.toMessage()
                          : null,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    AppSpacing.gapLg,
                    AuthTextField(
                      label: l10n.password,
                      hint: l10n.passwordHint,
                      controller: _passwordController,
                      onChanged: (value) {
                        ref
                            .read(registerFormProvider.notifier)
                            .passwordChanged(value);
                      },
                      errorText: formState.showErrorMessages
                          ? formState.passwordFailure?.toMessage()
                          : null,
                      obscureText: _obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
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
                      text: l10n.register,
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
                          ref
                              .read(authProvider.notifier)
                              .startOAuthLogin(provider.name),
                        );
                      },
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.alreadyHaveAccount,
                          style: TextStyle(
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondaryLight,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => const LoginRoute().go(context),
                          child: Text(
                            l10n.signIn,
                            style: const TextStyle(
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
