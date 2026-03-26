import 'package:flutter/material.dart';

import '../widgets/section_placeholder.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionPlaceholder(
      title: 'Guide',
      subtitle: 'Browse guided learning paths and tips.',
      icon: Icons.menu_book,
    );
  }
}
