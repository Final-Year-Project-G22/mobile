import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';
import '../../../taxonomy/application/providers/taxonomy_providers.dart';
import '../../../taxonomy/domain/entities/tag.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return sectorsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (sectors) {
        final rootSectors = sectors.where((s) => s.parentId == null).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildChip(
                      context,
                      label: AppLocalizations.of(context).all,
                      isSelected: selectedSectorId == null,
                      isDark: isDark,
                      onTap: () => onSectorSelected(null),
                    ),
                    AppSpacing.gapHorizontalXs,
                    ...rootSectors.map(
                      (sector) => Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.xs),
                        child: _buildChip(
                          context,
                          label: sector.name,
                          isSelected: selectedSectorId == sector.id,
                          isDark: isDark,
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
              _buildTagSection(context, ref, tagsAsync, isDark),
          ],
        );
      },
    );
  }

  Widget _buildTagSection(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<Tag>> tagsAsync,
    bool isDark,
  ) {
    return tagsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (tags) {
        final relevantTags = tags
            .where((t) => _isTagRelevant(t, selectedTagIds))
            .toList();

        if (relevantTags.isEmpty) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.xs,
            AppSpacing.md,
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
                isDark: isDark,
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

  Widget _buildChip(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accent
              : (isDark ? AppColors.slate700 : AppColors.slate100),
          borderRadius: AppSpacing.borderRadiusFull,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected
                ? Colors.white
                : (isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight),
          ),
        ),
      ),
    );
  }

  Widget _buildTagChip(
    BuildContext context, {
    required Tag tag,
    required bool isSelected,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accent.withValues(alpha: 0.15)
              : (isDark ? AppColors.slate800 : AppColors.slate50),
          borderRadius: AppSpacing.borderRadiusFull,
          border: Border.all(
            color: isSelected
                ? AppColors.accent
                : (isDark ? AppColors.slate600 : AppColors.slate200),
          ),
        ),
        child: Text(
          tag.name,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected
                ? AppColors.accent
                : (isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight),
          ),
        ),
      ),
    );
  }
}
