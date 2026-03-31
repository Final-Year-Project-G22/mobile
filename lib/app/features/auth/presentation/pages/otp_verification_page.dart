import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/di/auth_providers.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../router/routes.dart';
import '../../application/auth_notifier.dart';
import '../../domain/failures/auth_user_failure.dart';
import '../widgets/auth_button.dart';

class OtpVerificationPage extends ConsumerStatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  ConsumerState<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends ConsumerState<OtpVerificationPage> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isLoading = false;
  String? _errorMessage;
  Timer? _resendTimer;
  int _resendCooldown = 0;

  @override
  void initState() {
    super.initState();
    _startResendCooldown();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    _resendTimer?.cancel();
    super.dispose();
  }

  void _startResendCooldown() {
    setState(() {
      _resendCooldown = 60;
    });
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _resendCooldown--;
        if (_resendCooldown <= 0) {
          timer.cancel();
        }
      });
    });
  }

  String get _otpCode {
    return _controllers.map((c) => c.text).join();
  }

  Future<void> _verifyOtp() async {
    if (_otpCode.length != 6) {
      setState(() {
        _errorMessage = 'Please enter the 6-digit code';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.verifyOtp(otp: _otpCode);

    result.fold(
      (failure) {
        setState(() {
          _isLoading = false;
          _errorMessage = failure.maybeWhen(
            invalidOtp: (message) => message ?? 'Invalid OTP code',
            networkError: (message) => message ?? 'No internet connection',
            serverError: (message) => message ?? 'Server error',
            orElse: () => 'An error occurred',
          );
        });
      },
      (message) {
        setState(() {
          _isLoading = false;
        });
        ref.read(authProvider.notifier).completeVerification();
        const HomeRoute().go(context);
      },
    );
  }

  Future<void> _resendOtp() async {
    if (_resendCooldown > 0) return;

    final repository = ref.read(authRepositoryProvider);
    await repository.resendOtp();
    _startResendCooldown();
  }

  void _onDigitChanged(int index, String value) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    setState(() {
      _errorMessage = null;
    });
  }

  void _onKeyPressed(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        _controllers[index].text.isEmpty &&
        index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ref.listen(authProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) {
          if (error is AuthUserFailure) {
            setState(() {
              _errorMessage = error.maybeWhen(
                invalidOtp: (message) => message ?? 'Invalid OTP code',
                networkError: (message) => message ?? 'No internet connection',
                serverError: (message) => message ?? 'Server error',
                orElse: () => 'An error occurred',
              );
              _isLoading = false;
            });
          }
        },
      );
    });

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xxl),
              Text(
                'Verify Your Email',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
              ),
              AppSpacing.gapVerticalXs,
              Text(
                'Enter the 6-digit code sent to your email',
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Container(
                    width: 45,
                    height: 55,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.accent,
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: AppColors.error),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1),
                      ],
                      onChanged: (value) => _onDigitChanged(index, value),
                    ),
                  );
                }),
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: AppColors.error),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: AppSpacing.xl),
              AuthButton(
                text: 'Verify',
                isLoading: _isLoading,
                onPressed: _verifyOtp,
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code? ",
                    style: TextStyle(
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                  ),
                  GestureDetector(
                    onTap: _resendCooldown > 0 ? null : _resendOtp,
                    child: Text(
                      _resendCooldown > 0 ? 'Resend in ${_resendCooldown}s' : 'Resend',
                      style: TextStyle(
                        color: _resendCooldown > 0
                            ? (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight)
                            : AppColors.accent,
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
    );
  }
}
