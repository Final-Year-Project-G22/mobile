import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/router/app_router.dart';

class DeepLinkListener extends ConsumerStatefulWidget {
  const DeepLinkListener({required this.child, super.key});
  final Widget child;

  @override
  ConsumerState<DeepLinkListener> createState() => _DeepLinkListenerState();
}

class _DeepLinkListenerState extends ConsumerState<DeepLinkListener> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _sub = AppLinks().uriLinkStream.listen((uri) {
      if (uri.path == '/payment/success') {
        final txRef = uri.queryParameters['tx_ref'];
        if (txRef != null) {
          unawaited(
            ref.read(routerProvider).push('/payment/success?tx_ref=$txRef'),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    unawaited(_sub?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
