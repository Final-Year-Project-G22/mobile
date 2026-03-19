import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/constants/app_colors.dart';
import 'package:mobile/app/constants/app_spacing.dart';
import 'package:mobile/core/di/providers.dart';
import 'package:mobile/features/auth/domain/failures/auth_user_failure.dart';
import 'package:mobile/features/auth/domain/failures/auth_value_failure.dart';
import 'package:mobile/features/auth/presentation/widgets/auth_button.dart';
import 'package:mobile/features/auth/presentation/widgets/auth_text_field.dart';

class LogInPage extends ConsumerStatefulWidget {
  const LogInPage({super.key});

  @override
  ConsumerState<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends ConsumerState<LogInPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    Future.microtask(() {
      ref.read(authNotifierProvider.notifier).resetAuthForm();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _getErrorText(dynamic valueObject, bool showError) {
    if (!showError) return null;

    final value = valueObject.value;
    return value.fold((failure) => _mapFailureToMessage(failure), (_) => null);
  }

  String _mapFailureToMessage(AuthValueFailure failure) {
    return failure.maybeWhen(
      emptyField: (failedValue, fieldName) => '$fieldName is required',
      shortName: (failedValue, fieldName) =>
          '$fieldName must be at least 3 characters',
      invalidEmail: (_) => 'Invalid email address',
      invalidPassword: (_) => 'Password must be at least 8 characters',
      orElse: () => 'Invalid input',
    );
  }

  String? _getServerErrorMessage(AuthUserFailure failure) {
    return failure.maybeWhen(
      emailAlreadyInUse: () => 'Email already in use',
      invalidEmailAndPasswordCombination: () => 'Invalid email or password',
      serverError: () => 'Server error. Please try again.',
      networkError: () => 'No internet connection',
      orElse: () => 'An error occurred',
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ref.listen(authNotifierProvider, (previous, next) {
      next.authFailureOrSuccessOption.fold(
        () {},
        (either) => either.fold(
          (failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_getServerErrorMessage(failure) ?? 'Error'),
                backgroundColor: AppColors.error,
              ),
            );
          },
          (_) {
            if (mounted) {
              ref.read(authSessionProvider.notifier).setAuthenticated();
              context.go('/home');
            }
          },
        ),
      );
    });

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.xxl),
                Text(
                  'LogIn',
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
                  'LogIn to get started',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                AppSpacing.gapLg,
                AuthTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  controller: _emailController,
                  onChanged: (value) {
                    ref.read(authNotifierProvider.notifier).emailChanged(value);
                  },
                  errorText: _getErrorText(
                    authState.email,
                    authState.showErrorMessages,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                AppSpacing.gapLg,
                AuthTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: _passwordController,
                  onChanged: (value) {
                    ref
                        .read(authNotifierProvider.notifier)
                        .passwordChanged(value);
                  },
                  errorText: _getErrorText(
                    authState.password,
                    authState.showErrorMessages,
                  ),
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
                  text: 'Login',
                  isLoading: authState.isSubmitting,
                  onPressed: () {
                    ref.read(authNotifierProvider.notifier).onUserLogin();
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go('/register'),
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
