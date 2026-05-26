import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../constants/app_spacing.dart';
import '../../application/auth_form_notifier.dart';
import '../../application/auth_notifier.dart';
import '../../domain/failures/auth_user_failure.dart';
import '../../domain/failures/auth_value_failure.dart';
import '../widgets/auth_button.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final _existingController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscureExisting = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _existingController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final formState = ref.watch(changePasswordFormProvider);

    ref
      ..listen(changePasswordFormProvider, (prev, next) {
        if (next.isSuccess && prev?.isSuccess != true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.passwordUpdated)),
          );
          Navigator.of(context).pop();
        }
      })
      ..listen(authProvider, (previous, next) {
      next.whenOrNull(
        error: (error, _) {
          if (error is AuthUserFailure) {
            final message = error.maybeWhen(
              passwordChangeFailed: (msg) =>
                  msg ?? l10n.errorPasswordChangeFailed,
              networkError: (msg) => msg ?? l10n.errorNetwork,
              serverError: (msg) => msg ?? l10n.errorServer,
              orElse: () => l10n.errorPasswordChangeFailed,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          }
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: Text(l10n.changePassword)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _existingController,
              obscureText: _obscureExisting,
              decoration: InputDecoration(
                labelText: l10n.currentPassword,
                hintText: l10n.passwordHint,
                errorText: formState.showErrorMessages
                    ? formState.existingPasswordFailure?.toMessage()
                    : null,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureExisting
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () =>
                      setState(() => _obscureExisting = !_obscureExisting),
                ),
              ),
              onChanged: (value) =>
                  ref.read(changePasswordFormProvider.notifier).existingPasswordChanged(value),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _newController,
              obscureText: _obscureNew,
              decoration: InputDecoration(
                labelText: l10n.newPassword,
                hintText: l10n.passwordHint,
                errorText: formState.showErrorMessages
                    ? formState.newPasswordFailure?.toMessage()
                    : null,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureNew ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () =>
                      setState(() => _obscureNew = !_obscureNew),
                ),
              ),
              onChanged: (value) =>
                  ref.read(changePasswordFormProvider.notifier).newPasswordChanged(value),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _confirmController,
              obscureText: _obscureConfirm,
              decoration: InputDecoration(
                labelText: l10n.confirmPassword,
                hintText: l10n.passwordHint,
                errorText: formState.showErrorMessages
                    ? formState.confirmPasswordFailure?.toMessage()
                    : null,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirm
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () =>
                      setState(() => _obscureConfirm = !_obscureConfirm),
                ),
              ),
              onChanged: (value) =>
                  ref.read(changePasswordFormProvider.notifier).confirmPasswordChanged(value),
            ),
            const SizedBox(height: AppSpacing.xl),
            AuthButton(
              text: l10n.save,
              isLoading: formState.isSubmitting,
              onPressed: () =>
                  ref.read(changePasswordFormProvider.notifier).submit(),
            ),
          ],
        ),
      ),
    );
  }
}
