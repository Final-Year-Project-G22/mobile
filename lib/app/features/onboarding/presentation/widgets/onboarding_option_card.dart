import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';

class OnboardingOptionCard extends StatelessWidget {
  const OnboardingOptionCard({
    required this.title,
    required this.selected,
    super.key,
    this.subtitle,
    this.onTap,
    this.leading,
  });

  final String title;
  final String? subtitle;
  final bool selected;
  final VoidCallback? onTap;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = selected
        ? (isDark ? AppColors.slate700 : AppColors.slate100)
        : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight);
    final borderColor = selected
        ? AppColors.accent
        : (isDark ? AppColors.borderDark : AppColors.borderLight);

    return InkWell(
      onTap: onTap,
      borderRadius: AppSpacing.borderRadiusLg,
      child: Ink(
        padding: AppSpacing.paddingMd,
        decoration: BoxDecoration(
          color: background,
          borderRadius: AppSpacing.borderRadiusLg,
          border: Border.all(color: borderColor, width: selected ? 1.5 : 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (leading != null) ...[
              leading!,
              AppSpacing.gapHorizontalSm,
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                  if (subtitle != null) ...[
                    AppSpacing.gapVerticalXxs,
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle,
                color: AppColors.accent,
                size: 20,
              )
            else
              Icon(
                Icons.circle_outlined,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
