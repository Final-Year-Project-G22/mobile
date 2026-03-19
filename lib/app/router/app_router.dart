import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/di/providers.dart';
import 'package:mobile/features/auth/presentation/pages/login_page.dart';
import 'package:mobile/features/auth/presentation/pages/register_page.dart';
import 'package:mobile/features/splash/presentation/pages/splash_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final bootstrap = ref.watch(authBootstrapProvider);
  final isAuthenticated = ref.watch(authSessionProvider);
  return GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LogInPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Home'))),
      ),
    ],
    redirect: (context, state) {
      final location = state.matchedLocation;
      final isAuthPage = location == '/login' || location == '/register';
      final isSplash = location == '/splash';
      if (bootstrap.isLoading) {
        return isSplash ? null : '/splash';
      }
      if (!isAuthenticated) {
        if (isSplash) return '/login';
        return isAuthPage ? null : '/login';
      }
      if (isAuthPage || isSplash) return '/home';
      return null;
    },
  );
});
