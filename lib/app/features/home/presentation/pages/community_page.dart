import 'package:flutter/material.dart';

import '../widgets/section_placeholder.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SectionPlaceholder(
      title: 'Community',
      subtitle: 'Join discussions and learn from other users.',
      icon: Icons.groups,
    );
  }
}
