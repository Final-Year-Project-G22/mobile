import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_spacing.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          _buildChip(
            context,
            label: 'All',
            isSelected: selectedCategorySlug.isEmpty,
            isDark: isDark,
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
                isDark: isDark,
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
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : (isDark ? AppColors.slate700 : AppColors.slate100),
          borderRadius: AppSpacing.borderRadiusFull,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight),
          ),
        ),
      ),
    );
  }
}
