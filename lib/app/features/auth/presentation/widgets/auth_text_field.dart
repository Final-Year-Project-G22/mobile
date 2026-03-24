import 'package:flutter/material.dart';
import 'package:mobile/app/constants/app_colors.dart';

class AuthTextField extends StatelessWidget {
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

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.textLabelDark : AppColors.textLabelLight,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          textCapitalization: textCapitalization,
          textInputAction: textInputAction,
          style: TextStyle(fontSize: 16, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 16, color: isDark ? AppColors.textHintDark : AppColors.textHintLight),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: isDark ? AppColors.inputFillDark : AppColors.inputFillLight,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.accent, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error, width: 2),
            ),
            errorText: errorText,
            errorStyle: const TextStyle(color: AppColors.error, fontSize: 12),
          ),
        ),
      ],
    );
  }
}
