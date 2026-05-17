import 'package:flutter/material.dart';

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
    final colorScheme = Theme.of(context).colorScheme;

    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            isOutlined ? colorScheme.primary : colorScheme.onPrimary,
          ),
        ),
      );
    }

    return Text(text);
  }
}
