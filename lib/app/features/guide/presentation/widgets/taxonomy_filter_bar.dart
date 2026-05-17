import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/widgets/adisu_progress_indicator.dart';
import '../../../../constants/app_spacing.dart';
import '../../../taxonomy/application/providers/taxonomy_providers.dart';
import '../../../taxonomy/domain/entities/tag.dart';

/// M3 FilterChip-based taxonomy selector with sector + tag rows.
class TaxonomyFilterBar extends ConsumerWidget {
  const TaxonomyFilterBar({
    required this.selectedSectorId,
    required this.selectedTagIds,
    required this.onSectorSelected,
    required this.onTagToggled,
    required this.onClearFilters,
    super.key,
  });

  final String? selectedSectorId;
  final List<String> selectedTagIds;
  final ValueChanged<String?> onSectorSelected;
  final ValueChanged<String> onTagToggled;
  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectorsAsync = ref.watch(sectorsProvider);
    final tagsAsync = ref.watch(tagsProvider);

    return sectorsAsync.when(
      loading: () => const AdisuProgressIndicator.small(),
      error: (_, _) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Text(
            AppLocalizations.of(context).failedToLoadFilters,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ),
      data: (sectors) {
        final rootSectors = sectors.where((s) => s.parentId == null).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenH,
                vertical: AppSpacing.xs,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildSectorChip(
                      context,
                      label: AppLocalizations.of(context).all,
                      isSelected: selectedSectorId == null,
                      onTap: () => onSectorSelected(null),
                    ),
                    AppSpacing.gapHorizontalXs,
                    ...rootSectors.map(
                      (sector) => Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.xs),
                        child: _buildSectorChip(
                          context,
                          label: sector.name,
                          isSelected: selectedSectorId == sector.id,
                          onTap: () => onSectorSelected(
                            selectedSectorId == sector.id ? null : sector.id,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (selectedSectorId != null)
              _buildTagSection(context, ref, tagsAsync),
          ],
        );
      },
    );
  }

  Widget _buildTagSection(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<Tag>> tagsAsync,
  ) {
    return tagsAsync.when(
      loading: () => const AdisuProgressIndicator.small(),
      error: (_, _) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Text(
            AppLocalizations.of(context).failedToLoadFilters,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ),
      data: (tags) {
        final relevantTags = tags
            .where((t) => _isTagRelevant(t, selectedTagIds))
            .toList();

        if (relevantTags.isEmpty) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenH,
            AppSpacing.xs,
            AppSpacing.screenH,
            AppSpacing.xs,
          ),
          child: Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: relevantTags.map((tag) {
              final isSelected = selectedTagIds.contains(tag.id);
              return _buildTagChip(
                context,
                tag: tag,
                isSelected: isSelected,
                onTap: () => onTagToggled(tag.id),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  bool _isTagRelevant(Tag tag, List<String> selectedTagIds) {
    return selectedTagIds.contains(tag.id) || tag.isMultiSelect;
  }

  Widget _buildSectorChip(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
      selectedColor: colorScheme.secondaryContainer,
      checkmarkColor: colorScheme.onSecondaryContainer,
      labelStyle: textTheme.labelMedium?.copyWith(
        color: isSelected
            ? colorScheme.onSecondaryContainer
            : colorScheme.onSurfaceVariant,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusSm,
      ),
      side: isSelected
          ? BorderSide.none
          : BorderSide(color: colorScheme.outline),
      showCheckmark: false,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _buildTagChip(
    BuildContext context, {
    required Tag tag,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return FilterChip(
      label: Text(tag.name),
      selected: isSelected,
      onSelected: (_) => onTap(),
      selectedColor: colorScheme.secondaryContainer.withValues(alpha: 0.5),
      labelStyle: textTheme.labelSmall?.copyWith(
        color: isSelected
            ? colorScheme.onSecondaryContainer
            : colorScheme.onSurfaceVariant,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: AppSpacing.borderRadiusSm,
      ),
      side: BorderSide(
        color: isSelected ? colorScheme.secondary : colorScheme.outlineVariant,
      ),
      showCheckmark: isSelected,
      checkmarkColor: colorScheme.onSecondaryContainer,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
