import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/app/constants/app_colors.dart';
import 'package:mobile/app/constants/app_spacing.dart';
import 'package:mobile/app/features/auth/application/auth_form_notifier.dart';
import 'package:mobile/app/features/auth/application/auth_notifier.dart';
import 'package:mobile/app/features/auth/domain/failures/auth_user_failure.dart';
import 'package:mobile/app/features/auth/domain/failures/auth_value_failure.dart';
import 'package:mobile/app/features/auth/presentation/widgets/auth_button.dart';
import 'package:mobile/app/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:mobile/app/router/routes.dart';

class LogInPage extends ConsumerStatefulWidget {
  const LogInPage({super.key});

  @override
  ConsumerState<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends ConsumerState<LogInPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    Future.microtask(() {
      ref.read(loginFormProvider.notifier).reset();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(loginFormProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ref.listen(authProvider, (previous, next) {
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
                  label: 'Email',
                  hint: 'Enter your email',
                  controller: _emailController,
                  onChanged: (value) {
                    ref.read(loginFormProvider.notifier).emailChanged(value);
                  },
                  errorText: formState.showErrorMessages ? formState.emailFailure?.toMessage() : null,
                  keyboardType: TextInputType.emailAddress,
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
                    ref.read(loginFormProvider.notifier).submit();
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
                    ),
                    GestureDetector(
                      onTap: () => const RegisterRoute().go(context),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.w600),
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
