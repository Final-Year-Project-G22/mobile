import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({
    required this.languages,
    required this.selected,
    required this.onSelect,
    super.key,
  });

  final List<String> languages;
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: languages.map((lang) {
        final isSelected = lang == selected;
        return ChoiceChip(
          label: Text(lang.toUpperCase()),
          selected: isSelected,
          onSelected: (_) => onSelect(lang),
        );
      }).toList(),
    );
  }
}
