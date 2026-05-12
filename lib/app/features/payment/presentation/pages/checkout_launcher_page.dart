import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../app/router/routes.dart';

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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _launchCheckout());
  }

  Future<void> _launchCheckout() async {
    if (!mounted) return;

    debugPrint(
      '[PAYMENT] CheckoutLauncherPage launching: url=${widget.checkoutUrl}',
    );

    if (kIsWeb) {
      debugPrint(
        '[PAYMENT] CheckoutLauncherPage: web platform, using url_launcher',
      );
      await _launchOnWeb();
      return;
    }

    debugPrint(
      '[PAYMENT] CheckoutLauncherPage: mobile platform, using flutter_web_auth_2',
    );
    try {
      await FlutterWebAuth2.authenticate(
        url: widget.checkoutUrl,
        callbackUrlScheme: 'adisu',
      );

      if (!mounted) return;
      context.replace(PaymentResultRoute(txRef: widget.txRef).location);
    } on Exception catch (e) {
      if (!mounted) return;
      final message = e.toString().toLowerCase();
      if (message.contains('cancelled') || message.contains('canceled')) {
        context.replace(const PlansRoute().location);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Payment cancelled')),
        );
      } else {
        context.replace(PaymentResultRoute(txRef: widget.txRef).location);
      }
    }
  }

  Future<void> _launchOnWeb() async {
    final uri = Uri.parse(widget.checkoutUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }

    if (!mounted) return;
    context.replace(PaymentResultRoute(txRef: widget.txRef).location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Opening secure payment...'),
          ],
        ),
      ),
    );
  }
}
