import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/app_config.dart';
import '../../../router/app_router.dart';
import '../../../router/routes.dart';
import 'auth_notifier.dart';
import 'auth_oauth_state.dart';

final oauthDeepLinkCoordinatorProvider = Provider<void>((ref) {
  final appLinks = AppLinks();
  final router = ref.read(routerProvider);

  String? lastProcessedUri;

  Future<void> processDeepLink(Uri uri) async {
    if (!_isValidOAuthCallbackUri(uri)) {
      return;
    }

    final uriKey = uri.toString();
    if (lastProcessedUri == uriKey) {
      return;
    }
    lastProcessedUri = uriKey;

    await ref.read(authProvider.notifier).handleOAuthDeepLink(uri);

    final authState = ref.read(authProvider);
    if (authState.value?.isAuthenticated ?? false) {
      router.go(const HomeRoute().location);
      return;
    }

    final oauthState = ref.read(authOAuthStateProvider);
    if (oauthState.pendingOAuthEmail != null) {
      router.go(const OAuthCompleteEmailRoute().location);
      return;
    }

    router.go(const LoginRoute().location);
  }

  unawaited(() async {
    final initialUri = await appLinks.getInitialLink();
    if (initialUri == null) {
      return;
    }
    await processDeepLink(initialUri);
  }());

  final subscription = appLinks.uriLinkStream.listen(
    (uri) => unawaited(processDeepLink(uri)),
  );

  ref.onDispose(subscription.cancel);
});

bool _isValidOAuthCallbackUri(Uri uri) {
  final callbackUri = AppConfig.oauthCallbackUri;
  if (uri.scheme != callbackUri.scheme || uri.host != callbackUri.host) {
    return false;
  }

  final expectedPath = _normalizePath(callbackUri.path);
  final incomingPath = _normalizePath(uri.path);
  return incomingPath == expectedPath || incomingPath.startsWith('$expectedPath/');
}

String _normalizePath(String path) {
  final withLeadingSlash = path.startsWith('/') ? path : '/$path';
  return withLeadingSlash.endsWith('/') && withLeadingSlash.length > 1
      ? withLeadingSlash.substring(0, withLeadingSlash.length - 1)
      : withLeadingSlash;
}
