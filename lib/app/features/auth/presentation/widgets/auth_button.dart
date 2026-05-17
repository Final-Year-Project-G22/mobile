import 'package:flutter/material.dart';

import '../../../../../shared/widgets/adisu_progress_indicator.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    required this.text,
    super.key,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
  });
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        // Uses OutlinedButtonTheme from AppTheme
        child: _buildChild(context, isOutlined: true),
      );
    }

    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      // Uses FilledButtonTheme from AppTheme
      child: _buildChild(context),
    );
  }

  Widget _buildChild(BuildContext context, {bool isOutlined = false}) {
    if (isLoading) {
      return const AdisuProgressIndicator.small();
    }

    return Text(text);
  }
}
