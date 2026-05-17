import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/di/auth_providers.dart';
import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../core/widgets/locale_toggle_button.dart';

import '../../../../constants/app_spacing.dart';
import '../../../../router/routes.dart';
import '../../application/auth_notifier.dart';
import '../../domain/failures/auth_user_failure.dart';
import '../widgets/auth_button.dart';

class OtpVerificationPage extends ConsumerStatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  ConsumerState<OtpVerificationPage> createState() =>
      _OtpVerificationPageState();
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
        _errorMessage = AppLocalizations.of(context).otpCodeHint;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final repository = ref.read(authRepositoryProvider);
    final result = await repository.verifyOtp(otp: _otpCode);

    await result.fold(
      (failure) {
        setState(() {
          _isLoading = false;
          _errorMessage = failure.maybeWhen(
            invalidOtp: (message) =>
                message ?? AppLocalizations.of(context).errorInvalidOtp,
            networkError: (message) =>
                message ?? AppLocalizations.of(context).errorNetwork,
            serverError: (message) =>
                message ?? AppLocalizations.of(context).errorServer,
            orElse: () => AppLocalizations.of(context).errorGeneric,
          );
        });
      },
      (message) async {
        setState(() {
          _isLoading = false;
        });
        await ref.read(authProvider.notifier).completeVerification();
        if (!mounted) return;

        final authState = ref.read(authProvider);
        final isAuthenticated = authState.value?.isAuthenticated ?? false;
        if (isAuthenticated) {
          const OnboardingRoute().go(context);
        }
        // If not authenticated, the authProvider listener below will show the error
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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    ref.listen(authProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) {
          if (error is AuthUserFailure) {
            setState(() {
              _errorMessage = error.maybeWhen(
                invalidOtp: (message) => message ?? l10n.errorInvalidOtp,
                networkError: (message) => message ?? l10n.errorNetwork,
                serverError: (message) => message ?? l10n.errorServer,
                orElse: () => l10n.errorGeneric,
              );
              _isLoading = false;
            });
          }
        },
      );
    });

    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
            top: 8,
            right: 8,
            child: LocaleToggleButton(),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.screenH),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.xxl),
                  Text(
                    l10n.verifyEmail,
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  AppSpacing.gapVerticalXs,
                  Text(
                    l10n.otpSubtitle,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (index) {
                      return Container(
                        width: 46,
                        height: 56,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                            // We explicitly specify borders here as OTP boxes
                            // look different from typical text fields.
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppSpacing.radiusSm,
                              ),
                              borderSide: BorderSide(
                                color: colorScheme.outlineVariant,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppSpacing.radiusSm,
                              ),
                              borderSide: BorderSide(
                                color: colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                AppSpacing.radiusSm,
                              ),
                              borderSide: BorderSide(
                                color: colorScheme.error,
                              ),
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
                      style: TextStyle(color: colorScheme.error),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: AppSpacing.xl),
                  AuthButton(
                    text: l10n.verify,
                    isLoading: _isLoading,
                    onPressed: _verifyOtp,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.didNotReceiveCode,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      AppSpacing.gapHorizontalXs,
                      TextButton(
                        onPressed: _resendCooldown > 0 ? null : _resendOtp,
                        style: TextButton.styleFrom(
                          minimumSize: const Size(48, 40),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          _resendCooldown > 0
                              ? l10n.resendIn(_resendCooldown)
                              : l10n.resend,
                          style: textTheme.labelLarge?.copyWith(
                            color: _resendCooldown > 0
                                ? colorScheme.onSurfaceVariant
                                : colorScheme.primary,
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
        ],
      ),
    );
  }
}
