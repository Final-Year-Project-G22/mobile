import 'package:flutter/material.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../widgets/section_placeholder.dart';

class TemplatesPage extends StatelessWidget {
  const TemplatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SectionPlaceholder(
      title: l10n.templates,
      subtitle: l10n.templatesPlaceholderSubtitle,
      icon: Icons.grid_view,
    );
  }
}
