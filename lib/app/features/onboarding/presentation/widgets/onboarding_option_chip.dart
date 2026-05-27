import 'package:flutter/material.dart';

import '../../../../../shared/widgets/styled_filter_chip.dart';

class OnboardingOptionChip extends StatelessWidget {
  const OnboardingOptionChip({
    required this.label,
    required this.selected,
    super.key,
    this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return StyledFilterChip(
      label: label,
      isSelected: selected,
      onSelected: (_) => onTap?.call(),
    );
  }
}
