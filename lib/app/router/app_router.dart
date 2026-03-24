import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/features/auth/application/auth_notifier.dart';
import 'package:mobile/app/features/auth/presentation/pages/login_page.dart';
import 'package:mobile/app/features/auth/presentation/pages/register_page.dart';

class _AuthRefreshNotifier extends ChangeNotifier {
  final Ref _ref;
  ProviderSubscription? _subscription;
  _AuthRefreshNotifier(this._ref) {
    _subscription = _ref.listen(authProvider, (previous, next) {
      notifyListeners();
    });
  }
  @override
  void dispose() {
    _subscription?.close();
    super.dispose();
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final authRefreshNotifier = _AuthRefreshNotifier(ref);
  ref.onDispose(authRefreshNotifier.dispose);

  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    refreshListenable: authRefreshNotifier,
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const Scaffold(body: Center(child: Text('Splash'))),
      ),
      GoRoute(path: '/login', name: 'login', builder: (context, state) => const LogInPage()),
      GoRoute(path: '/register', name: 'register', builder: (context, state) => const RegisterPage()),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const Scaffold(body: Center(child: Text('Home'))),
      ),
    ],
    redirect: (context, state) {
      // Read auth state INSIDE redirect - gets current value
      final authState = ref.read(authProvider);
      final location = state.matchedLocation;
      final isAuthPage = location == '/login' || location == '/register';
      final isAuthenticated = authState.value?.isAuthenticated ?? false;
      // While loading, stay on current page
      if (authState.isLoading) {
        return null;
      }
      // Not authenticated → redirect to login (unless already there)
      if (!isAuthenticated) {
        return isAuthPage ? null : '/login';
      }
      // Authenticated → redirect away from auth pages to home
      return isAuthPage ? '/home' : null;
    },
  );
});
