import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/otp_verification_page.dart';
import '../features/auth/presentation/pages/oauth_callback_page.dart';
import '../features/auth/presentation/pages/oauth_complete_email_page.dart';
import '../features/auth/presentation/pages/register_page.dart';
import '../features/home/presentation/pages/home_shell_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/splash/presentation/pages/splash_page.dart';

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

@TypedGoRoute<OtpVerificationRoute>(path: '/otp-verification')
class OtpVerificationRoute extends GoRouteData with $OtpVerificationRoute {
  const OtpVerificationRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const OtpVerificationPage();
}

@TypedGoRoute<OAuthCallbackRoute>(path: '/oauth/callback')
class OAuthCallbackRoute extends GoRouteData with $OAuthCallbackRoute {
  const OAuthCallbackRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const OAuthCallbackPage();
}

@TypedGoRoute<OAuthCompleteEmailRoute>(path: '/oauth/complete-email')
class OAuthCompleteEmailRoute extends GoRouteData with $OAuthCompleteEmailRoute {
  const OAuthCompleteEmailRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const OAuthCompleteEmailPage();
}

@TypedShellRoute<MainAppShellRoute>(
  routes: [TypedGoRoute<HomeRoute>(path: '/home')],
)
class MainAppShellRoute extends ShellRouteData {
  const MainAppShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) =>
      const HomeShellPage();
}

@TypedGoRoute<ProfileRoute>(path: '/profile')
class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const ProfilePage();
}

class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const Scaffold(body: Center(child: Text('Home - TODO: Create HomePage')));
}
