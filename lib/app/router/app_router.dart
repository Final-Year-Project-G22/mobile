import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/features/auth/application/auth_notifier.dart';

import 'routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  final loginLocation = const LoginRoute().location;
  final registerLocation = const RegisterRoute().location;

  return GoRouter(
    initialLocation: loginLocation,
    debugLogDiagnostics: true,
    routes: $appRoutes,
    redirect: (context, state) {
      final location = state.matchedLocation;
      final isAuthPage = location == loginLocation || location == registerLocation;

      // While loading, stay on current page
      if (authState.isLoading) {
        return null;
      }

      final isAuthenticated = authState.value?.isAuthenticated ?? false;

      // Not authenticated → redirect to login (unless already on auth page)
      if (!isAuthenticated) {
        return isAuthPage ? null : loginLocation;
      }

      // Authenticated → redirect away from auth pages to home
      return isAuthPage ? const HomeRoute().location : null;
    },
  );
});
