import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/application/auth_notifier.dart';
import 'routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final loginLocation = const LoginRoute().location;
  final registerLocation = const RegisterRoute().location;
  final otpLocation = const OtpVerificationRoute().location;
  final splashLocation = const SplashRoute().location;
  final oauthCallbackLocation = const OAuthCallbackRoute().location;
  final oauthCompleteEmailLocation = const OAuthCompleteEmailRoute().location;

  final router = GoRouter(
    initialLocation: const SplashRoute().location,
    debugLogDiagnostics: true,
    routes: $appRoutes,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final location = state.matchedLocation;
      final isAuthPage =
          location == loginLocation ||
          location == registerLocation ||
          location == otpLocation ||
          location == oauthCallbackLocation ||
          location == oauthCompleteEmailLocation;

      if (authState.isLoading) return null;

      final isAuthenticated = authState.value?.isAuthenticated ?? false;
      final isPendingVerification = authState.value?.isPendingVerification ?? false;

      if (isPendingVerification) {
        if (location == oauthCallbackLocation || location == oauthCompleteEmailLocation) {
          return null;
        }
        return location == otpLocation ? null : otpLocation;
      }

      if (location == splashLocation) {
        return isAuthenticated ? const HomeRoute().location : loginLocation;
      }

      if (!isAuthenticated) {
        return isAuthPage ? null : loginLocation;
      }

      return isAuthPage ? const HomeRoute().location : null;
    },
  );

  ref
    ..listen(authProvider, (_, _) {
      router.refresh();
    })
    ..onDispose(router.dispose);

  return router;
});
