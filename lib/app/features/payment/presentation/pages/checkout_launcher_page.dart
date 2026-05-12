import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/routes.dart';

class CheckoutLauncherPage extends ConsumerStatefulWidget {
  const CheckoutLauncherPage({required this.checkoutUrl, required this.txRef, super.key});

  final String checkoutUrl;
  final String txRef;

  @override
  ConsumerState<CheckoutLauncherPage> createState() => _CheckoutLauncherPageState();
}

class _CheckoutLauncherPageState extends ConsumerState<CheckoutLauncherPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _launchCheckout());
  }

  Future<void> _launchCheckout() async {
    if (!mounted) return;

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

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
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
