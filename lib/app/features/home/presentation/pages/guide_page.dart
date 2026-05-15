import 'package:flutter/material.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../widgets/section_placeholder.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SectionPlaceholder(
      title: l10n.guide,
      subtitle: l10n.guidePlaceholderSubtitle,
      icon: Icons.menu_book,
    );
  }
}
