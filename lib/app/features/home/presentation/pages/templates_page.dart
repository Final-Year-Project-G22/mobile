import 'package:flutter/material.dart';

import '../widgets/section_placeholder.dart';

class TemplatesPage extends StatelessWidget {
  const TemplatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionPlaceholder(
      title: 'Templates',
      subtitle: 'Use ready-made templates to move faster.',
      icon: Icons.grid_view,
    );
  }
}
