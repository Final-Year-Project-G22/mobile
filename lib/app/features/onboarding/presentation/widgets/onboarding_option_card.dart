import 'package:flutter/material.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final background = selected
        ? colorScheme.secondaryContainer
        : colorScheme.surface;
    final borderColor = selected
        ? colorScheme.secondary
        : colorScheme.outlineVariant;

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
                    style: textTheme.titleSmall?.copyWith(
                      color: selected
                          ? colorScheme.onSecondaryContainer
                          : colorScheme.onSurface,
                    ),
                  ),
                  if (subtitle != null) ...[
                    AppSpacing.gapVerticalXxs,
                    Text(
                      subtitle!,
                      style: textTheme.bodySmall?.copyWith(
                        color: selected
                            ? colorScheme.onSecondaryContainer
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (selected)
              Icon(
                Icons.check_circle,
                color: colorScheme.secondary,
                size: 20,
              )
            else
              Icon(
                Icons.circle_outlined,
                color: colorScheme.onSurfaceVariant,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
