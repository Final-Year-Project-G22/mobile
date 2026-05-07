import 'package:flutter/material.dart';

import '../../domain/entities/category_node.dart';
import 'category_tree.dart';

class CategoryDrawer extends StatelessWidget {
  const CategoryDrawer({
    required this.categories,
    required this.onSelect,
    super.key,
  });

  final List<dynamic> categories;
  final ValueChanged<String?> onSelect;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => onSelect(null),
                    child: const Text('Show All'),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index] as CategoryNode;
                  return CategoryTree(
                    node: category,
                    onSelect: onSelect,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
