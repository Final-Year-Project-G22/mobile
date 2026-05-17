import 'package:flutter/material.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
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
                  color: colorScheme.secondaryContainer,
                  borderRadius: AppSpacing.borderRadiusSm,
                ),
                child: Icon(
                  _iconForGuide(guide.icon),
                  color: colorScheme.onSecondaryContainer,
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
                      style: textTheme.titleSmall?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (guide.description != null) ...[
                      AppSpacing.gapVerticalXxs,
                      Text(
                        guide.description!,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (guide.sectorIds.isNotEmpty ||
                        guide.tagIds.isNotEmpty) ...[
                      AppSpacing.gapVerticalXxs,
                      _TaxonomyBadges(
                        sectorCount: guide.sectorIds.length,
                        tagCount: guide.tagIds.length,
                      ),
                    ],
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
  });

  final int sectorCount;
  final int tagCount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xxs,
      children: [
        if (sectorCount > 0)
          _Badge(
            label: l10n.guideSectorCount(sectorCount),
            color: colorScheme.onPrimaryContainer,
            background: colorScheme.primaryContainer,
          ),
        if (tagCount > 0)
          _Badge(
            label: l10n.guideTagCount(tagCount),
            color: colorScheme.onTertiaryContainer,
            background: colorScheme.tertiaryContainer,
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
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppSpacing.borderRadiusSm,
      ),
      child: Text(
        label,
        style: textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
