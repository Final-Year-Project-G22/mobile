import 'package:flutter/material.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../domain/entities/guide_card.dart';

class GuideCardWidget extends StatelessWidget {
  const GuideCardWidget({
    required this.guide,
    super.key,
    this.onTap,
  });

  final GuideCard guide;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusMd,
        side: BorderSide(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppSpacing.borderRadiusMd,
        child: Padding(
          padding: AppSpacing.paddingMd,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  borderRadius: AppSpacing.borderRadiusSm,
                ),
                child: Icon(
                  _iconForGuide(guide.icon),
                  color: AppColors.accent,
                  size: 22,
                ),
              ),
              AppSpacing.gapHorizontalSm,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      guide.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (guide.description != null) ...[
                      AppSpacing.gapVerticalXxs,
                      Text(
                        guide.description!,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (guide.sectorIds.isNotEmpty || guide.tagIds.isNotEmpty)
                      AppSpacing.gapVerticalXxs,
                    if (guide.sectorIds.isNotEmpty || guide.tagIds.isNotEmpty)
                      _TaxonomyBadges(
                        sectorCount: guide.sectorIds.length,
                        tagCount: guide.tagIds.length,
                        theme: theme,
                        isDark: isDark,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconForGuide(String? icon) {
    switch (icon) {
      case 'receipt_long':
        return Icons.receipt_long;
      case 'trending_up':
        return Icons.trending_up;
      case 'document_scanner':
        return Icons.document_scanner;
      default:
        return Icons.menu_book;
    }
  }
}

class _TaxonomyBadges extends StatelessWidget {
  const _TaxonomyBadges({
    required this.sectorCount,
    required this.tagCount,
    required this.theme,
    required this.isDark,
  });

  final int sectorCount;
  final int tagCount;
  final ThemeData theme;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: [
        if (sectorCount > 0)
          _Badge(
            label: l10n.guideSectorCount(sectorCount),
            color: theme.colorScheme.primary,
            background: theme.colorScheme.primaryContainer,
          ),
        if (tagCount > 0)
          _Badge(
            label: l10n.guideTagCount(tagCount),
            color: theme.colorScheme.tertiary,
            background: theme.colorScheme.tertiaryContainer,
          ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.label,
    required this.color,
    required this.background,
  });

  final String label;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }
}
