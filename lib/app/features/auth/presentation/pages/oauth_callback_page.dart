import 'package:flutter/material.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/widgets/adisu_progress_indicator.dart';

class OAuthCallbackPage extends StatelessWidget {
  const OAuthCallbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AdisuProgressIndicator(),
            const SizedBox(height: 12),
            Text(l10n.oAuthFinishingSignIn),
          ],
        ),
      ),
    );
  }
}
