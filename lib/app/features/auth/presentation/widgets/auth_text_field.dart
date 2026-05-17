import 'package:flutter/material.dart';

import '../../../../constants/app_spacing.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    required this.label,
    required this.hint,
    super.key,
    this.controller,
    this.onChanged,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
  });
  final String label;
  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final int maxLines;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          textCapitalization: textCapitalization,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffixIcon,
            errorText: errorText,
            // Uses InputDecorationTheme from AppTheme for borders, fill colors, etc.
          ),
        ),
      ],
    );
  }
}
