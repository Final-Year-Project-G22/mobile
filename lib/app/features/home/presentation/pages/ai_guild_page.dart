import 'package:flutter/material.dart';

import '../widgets/section_placeholder.dart';

class AiGuildPage extends StatelessWidget {
  const AiGuildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionPlaceholder(
      title: 'AI Guide',
      subtitle: 'Explore AI-powered tools and guild updates.',
      icon: Icons.auto_awesome,
    );
  }
}
