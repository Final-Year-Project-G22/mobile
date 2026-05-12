import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../../guide/domain/entities/guide_with_progress.dart';
import 'continue_guide_card.dart';

class ContinueWhereYouLeftOffRail extends StatelessWidget {
  const ContinueWhereYouLeftOffRail({
    required this.guides,
    required this.onGuideTap,
    super.key,
  });

  final List<GuideWithProgress> guides;
  final void Function(String guideSlug) onGuideTap;

  @override
  Widget build(BuildContext context) {
    if (guides.isEmpty) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'Continue Where You Left Off',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
        ),
        AppSpacing.gapVerticalSm,
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            itemCount: guides.length,
            separatorBuilder: (_, _) => AppSpacing.gapHorizontalSm,
            itemBuilder: (_, index) {
              final guide = guides[index];
              return ContinueGuideCard(
                guide: guide,
                onTap: () => onGuideTap(guide.slug),
              );
            },
          ),
        ),
      ],
    );
  }
}
