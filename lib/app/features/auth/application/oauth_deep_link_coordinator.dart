import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_config.dart';
import '../../../router/app_router.dart';
import '../../../router/routes.dart';
import '../domain/failures/auth_user_failure.dart';
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

    final accessToken = uri.queryParameters['access_token'];
    final refreshToken = uri.queryParameters['refresh_token'];
    final expiresAt = uri.queryParameters['expires_at'];
    final isNewUser = uri.queryParameters['is_new_user'] == 'true';
    final code = uri.queryParameters['code'];
    final stateParam = uri.queryParameters['state'];
    final error = uri.queryParameters['error'];
    final emailRequired = uri.queryParameters['email_required'] == 'true';

    if (accessToken != null && accessToken.isNotEmpty) {
      await _processDirectTokenFlow(
        ref,
        router,
        accessToken: accessToken,
        refreshToken: refreshToken ?? '',
        expiresAt: expiresAt ?? '',
        isNewUser: isNewUser,
      );
      return;
    }

    if (code != null && code.isNotEmpty && stateParam != null && stateParam.isNotEmpty) {
      await _processCodeStateFlow(ref, router, code: code, state: stateParam);
      return;
    }

    if (emailRequired) {
      await _processEmailRequiredFlow(ref, router);
      return;
    }

    if (error != null && error.isNotEmpty) {
      await _processErrorFlow(ref, router, uri, error);
      return;
    }
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

Future<void> _processDirectTokenFlow(
  Ref ref,
  GoRouter router, {
  required String accessToken,
  required String refreshToken,
  required String expiresAt,
  required bool isNewUser,
}) async {
  await ref
      .read(authProvider.notifier)
      .completeOAuthFromDeepLink(
        accessToken: accessToken,
        refreshToken: refreshToken,
        expiresAt: expiresAt,
        isNewUser: isNewUser,
      );

  final authState = ref.read(authProvider);
  if (authState.value?.isAuthenticated ?? false) {
    router.go(const HomeRoute().location);
  } else {
    router.go(const LoginRoute().location);
  }
}

Future<void> _processCodeStateFlow(
  Ref ref,
  GoRouter router, {
  required String code,
  required String state,
}) async {
  await ref
      .read(authProvider.notifier)
      .handleOAuthDeepLink(
        Uri(queryParameters: {'code': code, 'state': state}),
      );

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

Future<void> _processEmailRequiredFlow(
  Ref ref,
  GoRouter router,
) async {
  ref.read(authOAuthStateProvider.notifier).clearPendingEmailAndInProgress();
  router.go(const OAuthCompleteEmailRoute().location);
}

Future<void> _processErrorFlow(
  Ref ref,
  GoRouter router,
  Uri uri,
  String error,
) async {
  final message = uri.queryParameters['error_description'] ?? uri.queryParameters['message'] ?? 'OAuth login failed';

  ref
      .read(authOAuthStateProvider.notifier)
      .setError(
        AuthUserFailure.oauthCallbackInvalid(message: message),
      );

  router.go(const LoginRoute().location);
}

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
