import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/l10n/generated/app_localizations.dart';
import '../../../../../shared/widgets/adisu_progress_indicator.dart';
import '../../../../constants/app_spacing.dart';
import '../../../../router/routes.dart';

class CheckoutLauncherPage extends ConsumerStatefulWidget {
  const CheckoutLauncherPage({
    required this.checkoutUrl,
    required this.txRef,
    super.key,
  });

  final String checkoutUrl;
  final String txRef;

  @override
  ConsumerState<CheckoutLauncherPage> createState() =>
      _CheckoutLauncherPageState();
}

class _CheckoutLauncherPageState extends ConsumerState<CheckoutLauncherPage> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _launchCheckout());
  }

  Future<void> _launchCheckout() async {
    if (!mounted) return;

    final uri = Uri.parse(widget.checkoutUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }

    if (!mounted || _navigated) return;
    _navigated = true;
    context.replace(PaymentResultRoute(txRef: widget.txRef).location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AdisuProgressIndicator(),
            const SizedBox(height: AppSpacing.md),
            Text(AppLocalizations.of(context).openingSecurePayment),
          ],
        ),
      ),
    );
  }
}
