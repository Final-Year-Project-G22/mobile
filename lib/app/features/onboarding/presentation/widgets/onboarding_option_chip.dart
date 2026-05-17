import 'package:flutter/material.dart';

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
    // Instead of building a custom container with manual inkwell and border,
    // we use the standard M3 FilterChip which conforms to the design system.
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        if (onTap != null) onTap!();
      },
      showCheckmark: false,
    );
  }
}
