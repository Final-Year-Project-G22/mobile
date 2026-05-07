import 'package:flutter/material.dart';

import '../../domain/entities/category_node.dart';

class CategoryTree extends StatelessWidget {
  const CategoryTree({
    required this.node,
    required this.onSelect,
    this.depth = 0,
    super.key,
  });

  final CategoryNode node;
  final ValueChanged<String?> onSelect;
  final int depth;

  @override
  Widget build(BuildContext context) {
    final hasChildren = node.children.isNotEmpty;

    if (!hasChildren) {
      return ListTile(
        contentPadding: EdgeInsets.only(left: 16 + depth * 24),
        title: Text(node.name),
        leading: node.icon != null ? Icon(_parseIcon(node.icon!)) : null,
        onTap: () => onSelect(node.id),
      );
    }

    return ExpansionTile(
      tilePadding: EdgeInsets.only(left: 16 + depth * 24, right: 16),
      title: Text(node.name),
      leading: node.icon != null ? Icon(_parseIcon(node.icon!)) : null,
      children: node.children
          .map(
            (child) => CategoryTree(
              node: child,
              onSelect: onSelect,
              depth: depth + 1,
            ),
          )
          .toList(),
    );
  }

  IconData _parseIcon(String name) {
    // Fallback mapping for common icon names
    switch (name.toLowerCase()) {
      case 'document':
      case 'file':
        return Icons.insert_drive_file;
      case 'form':
        return Icons.format_align_left;
      case 'business':
        return Icons.business;
      case 'legal':
        return Icons.gavel;
      case 'finance':
        return Icons.account_balance;
      case 'hr':
        return Icons.people;
      default:
        return Icons.folder;
    }
  }
}
