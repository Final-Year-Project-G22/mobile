import 'package:flutter/material.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../constants/app_spacing.dart';

/// M3 FilterChip-based category selector.
class CategoryFilterChips extends StatelessWidget {
  const CategoryFilterChips({
    required this.categories,
    required this.selectedCategorySlug,
    required this.onCategorySelected,
    super.key,
  });

  final List<String> categories;
  final String selectedCategorySlug;
  final ValueChanged<String> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenH),
      child: Row(
        children: [
          _buildChip(
            context,
            label: AppLocalizations.of(context).all,
            isSelected: selectedCategorySlug.isEmpty,
            onTap: () => onCategorySelected(''),
          ),
          AppSpacing.gapHorizontalXs,
          ...categories.map(
            (cat) => Padding(
              padding: const EdgeInsets.only(right: AppSpacing.xs),
              child: _buildChip(
                context,
                label: cat,
                isSelected: selectedCategorySlug == cat,
                onTap: () => onCategorySelected(cat),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(
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
}
