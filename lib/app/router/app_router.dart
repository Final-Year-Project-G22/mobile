import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/di/auth_providers.dart';
import '../features/auth/domain/entities/auth_status.dart';
import 'routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final loginLocation = const LoginRoute().location;
  final registerLocation = const RegisterRoute().location;
  final otpLocation = const OtpVerificationRoute().location;
  final splashLocation = const SplashRoute().location;
  final oauthCallbackLocation = const OAuthCallbackRoute().location;
  final oauthCompleteEmailLocation = const OAuthCompleteEmailRoute().location;
  final plansLocation = const PlansRoute().location;
  final paymentSuccessLocation = const PaymentSuccessRoute().location;

  final router = GoRouter(
    initialLocation: const SplashRoute().location,
    debugLogDiagnostics: true,
    routes: [
      ...$appRoutes,
    ],
    redirect: (context, state) {
      final authAsync = ref.read(resolvedAuthStatusProvider);
      final location = state.matchedLocation;
      final isAuthPage =
          location == loginLocation ||
          location == registerLocation ||
          location == otpLocation ||
          location == oauthCallbackLocation ||
          location == oauthCompleteEmailLocation;

      final isPublicPage =
          location == plansLocation || location == paymentSuccessLocation;

      if (authAsync.isLoading || authAsync.hasError) return null;

      final authStatus = authAsync.requireValue;
      final isAuthenticated = authStatus is Authenticated;
      final isPendingVerification = authStatus is PendingVerification;

      if (isPendingVerification) {
        if (location == oauthCallbackLocation ||
            location == oauthCompleteEmailLocation) {
          return null;
        }
        return location == otpLocation ? null : otpLocation;
      }

      if (location == splashLocation) {
        return isAuthenticated ? const HomeRoute().location : loginLocation;
      }

      if (!isAuthenticated) {
        return (isAuthPage || isPublicPage) ? null : loginLocation;
      }

      return isAuthPage ? const HomeRoute().location : null;
    },
  );

  ref
    ..listen(resolvedAuthStatusProvider, (_, _) {
      router.refresh();
    })
    ..onDispose(router.dispose);

  return router;
});
