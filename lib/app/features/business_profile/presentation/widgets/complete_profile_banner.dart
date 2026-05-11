import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';

class CompleteProfileBanner extends StatelessWidget {
  const CompleteProfileBanner({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isDark ? AppColors.slate800 : AppColors.slate100,
        borderRadius: BorderRadius.circular(AppSpacing.md),
        border: Border.all(
          color: isDark ? AppColors.slate700 : AppColors.slate300,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.business_center_outlined, color: AppColors.accent),
          AppSpacing.gapHorizontalSm,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Complete your business profile',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Unlock personalized guidance and better recommendations.',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: onTap,
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}
