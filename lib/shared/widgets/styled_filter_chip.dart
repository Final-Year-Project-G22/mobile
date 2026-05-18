import 'package:flutter/material.dart';

class StyledFilterChip extends StatelessWidget {
  const StyledFilterChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
    this.compact = false,
    this.avatar,
    super.key,
  });

  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;
  final bool compact;
  final Widget? avatar;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return FilterChip(
      avatar: avatar,
      label: Text(label),
      selected: isSelected,
      onSelected: onSelected,
      selectedColor: colorScheme.secondaryContainer,
      checkmarkColor: colorScheme.onSecondaryContainer,
      labelStyle: textTheme.labelMedium?.copyWith(
        color: isSelected
            ? colorScheme.onSecondaryContainer
            : colorScheme.onSurfaceVariant,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      side: isSelected
          ? BorderSide.none
          : BorderSide(color: colorScheme.outline),
      showCheckmark: false,
      visualDensity: compact ? VisualDensity.compact : null,
      materialTapTargetSize:
          compact ? MaterialTapTargetSize.shrinkWrap : null,
    );
  }
}
