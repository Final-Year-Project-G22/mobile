import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/app/features/auth/presentation/pages/login_page.dart';
import 'package:mobile/app/features/auth/presentation/pages/register_page.dart';
import 'package:mobile/app/features/splash/presentation/pages/splash_page.dart';

part 'routes.g.dart';

@TypedGoRoute<SplashRoute>(path: '/splash')
class SplashRoute extends GoRouteData with $SplashRoute {
  const SplashRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const SplashPage();
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const LogInPage();
}

@TypedGoRoute<RegisterRoute>(path: '/register')
class RegisterRoute extends GoRouteData with $RegisterRoute {
  const RegisterRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const RegisterPage();
}

@TypedShellRoute<MainAppShellRoute>(routes: [TypedGoRoute<HomeRoute>(path: '/home')])
class MainAppShellRoute extends ShellRouteData {
  const MainAppShellRoute();
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return Scaffold(
      appBar: AppBar(title: const Text('App')),
      body: navigator,
    );
  }
}

class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const Scaffold(body: Center(child: Text('Home - TODO: Create HomePage')));
}
