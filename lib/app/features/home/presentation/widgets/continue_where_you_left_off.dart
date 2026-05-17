import 'package:flutter/material.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
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

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
          child: Text(
            AppLocalizations.of(context).continueWhereYouLeftOff,
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        ),
        AppSpacing.gapVerticalSm,
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
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
