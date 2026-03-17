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

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
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
      invalidEmail: (_) => 'Invalid email address',
      invalidPassword: (_) => 'Password must be at least 8 characters',
      invalidFirstName: (_) => 'First name must be at least 3 characters',
      invalidLastName: (_) => 'Last name must be at least 3 characters',
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

    ref.listen<dynamic>(authNotifierProvider, (previous, next) {
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Registration successful!'),
                backgroundColor: AppColors.success,
              ),
            );
            context.go('/');
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
                  'Create Account',
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
                  'Sign up to get started',
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxl),
                AuthTextField(
                  label: 'First Name',
                  hint: 'Enter your first name',
                  controller: _firstNameController,
                  onChanged: (value) {
                    ref
                        .read(authNotifierProvider.notifier)
                        .firstNameChanged(value);
                  },
                  errorText: _getErrorText(
                    authState.firstName,
                    authState.showErrorMessages,
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                AppSpacing.gapLg,
                AuthTextField(
                  label: 'Last Name',
                  hint: 'Enter your last name',
                  controller: _lastNameController,
                  onChanged: (value) {
                    ref
                        .read(authNotifierProvider.notifier)
                        .lastNameChanged(value);
                  },
                  errorText: _getErrorText(
                    authState.lastName,
                    authState.showErrorMessages,
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
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
                  text: 'Register',
                  isLoading: authState.isSubmitting,
                  onPressed: () {
                    ref.read(authNotifierProvider.notifier).onUserRegister();
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go('/login'),
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
    );
  }
}
