import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/ai/presentation/pages/ai_chat_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/oauth_callback_page.dart';
import '../features/auth/presentation/pages/oauth_complete_email_page.dart';
import '../features/auth/presentation/pages/otp_verification_page.dart';
import '../features/auth/presentation/pages/register_page.dart';
import '../features/community/presentation/pages/community_home_page.dart';
import '../features/community/presentation/pages/thread_details_page.dart';
import '../features/guide/presentation/pages/guide_detail_page.dart';
import '../features/guide/presentation/pages/guide_list_page.dart';
import '../features/guide/presentation/pages/step_detail_page.dart';
import '../features/home/presentation/pages/home_dashboard_page.dart';
import '../features/home/presentation/pages/home_shell_page.dart';
import '../features/notifications/presentation/pages/inbox_page.dart';
import '../features/onboarding/presentation/pages/onboarding_page.dart';
import '../features/payment/presentation/pages/checkout_launcher_page.dart';
import '../features/payment/presentation/pages/payment_result_page.dart';
import '../features/payment/presentation/pages/plans_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/settings/presentation/pages/settings_page.dart';
import '../features/splash/presentation/pages/splash_page.dart';
import '../features/templates/presentation/pages/downloads_page.dart';
import '../features/templates/presentation/pages/template_detail_page.dart';
import '../features/templates/presentation/pages/templates_list_page.dart';

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

@TypedGoRoute<AiGuideRoute>(path: '/ai-guide')
class AiGuideRoute extends GoRouteData with $AiGuideRoute {
  const AiGuideRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const AiChatPage();
}

@TypedGoRoute<OnboardingRoute>(path: '/onboarding')
class OnboardingRoute extends GoRouteData with $OnboardingRoute {
  const OnboardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const OnboardingPage();
}

@TypedShellRoute<MainAppShellRoute>(
  routes: [
    TypedGoRoute<HomeRoute>(path: '/home'),
    TypedGoRoute<GuidesRoute>(path: '/guides'),
    TypedGoRoute<GuideDetailRoute>(path: '/guides/:guideSlug'),
    TypedGoRoute<StepDetailRoute>(path: '/guides/:guideSlug/step/:stepSlug'),
    TypedGoRoute<CommunityHomeRoute>(path: '/community'),
    TypedGoRoute<ThreadDetailsRoute>(path: '/community/thread/:threadId'),
    TypedGoRoute<TemplatesRoute>(path: '/templates'),
  ],
)
class MainAppShellRoute extends ShellRouteData {
  const MainAppShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) => HomeShellPage(navigator: navigator);
}

class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeDashboardPage();
}

class GuidesRoute extends GoRouteData with $GuidesRoute {
  const GuidesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const GuideListPage();
}

class GuideDetailRoute extends GoRouteData with $GuideDetailRoute {
  const GuideDetailRoute({required this.guideSlug});

  final String guideSlug;

  @override
  Widget build(BuildContext context, GoRouterState state) => GuideDetailPage(guideSlug: guideSlug);
}

class StepDetailRoute extends GoRouteData with $StepDetailRoute {
  const StepDetailRoute({required this.guideSlug, required this.stepSlug});

  final String guideSlug;
  final String stepSlug;

  @override
  Widget build(BuildContext context, GoRouterState state) => StepDetailPage(guideSlug: guideSlug, stepSlug: stepSlug);
}

class TemplatesRoute extends GoRouteData with $TemplatesRoute {
  const TemplatesRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const TemplatesListPage();
}

class TemplateDetailRoute extends GoRouteData {
  const TemplateDetailRoute({required this.groupId});
  final String groupId;

  @override
  Widget build(BuildContext context, GoRouterState state) => TemplateDetailPage(groupId: groupId);
}

class DownloadsRoute extends GoRouteData {
  const DownloadsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const DownloadsPage();
}

class CommunityHomeRoute extends GoRouteData with $CommunityHomeRoute {
  const CommunityHomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const CommunityHomePage();
}

class ThreadDetailsRoute extends GoRouteData with $ThreadDetailsRoute {
  const ThreadDetailsRoute({required this.threadId, this.threadTitle});
  final String threadId;
  final String? threadTitle;

  @override
  Widget build(BuildContext context, GoRouterState state) => ThreadDetailsPage(
    threadId: threadId,
    threadTitle: threadTitle ?? 'Thread',
  );
}

@TypedGoRoute<ProfileRoute>(path: '/profile')
class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const ProfilePage();
}

@TypedGoRoute<SettingsRoute>(path: '/settings')
class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SettingsPage();
}

@TypedGoRoute<InboxRoute>(path: '/inbox')
class InboxRoute extends GoRouteData with $InboxRoute {
  const InboxRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const InboxPage();
}

@TypedGoRoute<PlansRoute>(path: '/plans')
class PlansRoute extends GoRouteData with $PlansRoute {
  const PlansRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const PlansPage();
}

@TypedGoRoute<CheckoutLauncherRoute>(path: '/checkout')
class CheckoutLauncherRoute extends GoRouteData with $CheckoutLauncherRoute {
  const CheckoutLauncherRoute({required this.url, required this.txRef});

  final String url;
  final String txRef;

  @override
  Widget build(BuildContext context, GoRouterState state) => CheckoutLauncherPage(checkoutUrl: url, txRef: txRef);
}

@TypedGoRoute<PaymentResultRoute>(path: '/payment-result')
class PaymentResultRoute extends GoRouteData with $PaymentResultRoute {
  const PaymentResultRoute({required this.txRef});

  final String txRef;

  @override
  Widget build(BuildContext context, GoRouterState state) => PaymentResultPage(txRef: txRef);
}

@TypedGoRoute<PaymentSuccessRoute>(path: '/payment/success')
class PaymentSuccessRoute extends GoRouteData with $PaymentSuccessRoute {
  const PaymentSuccessRoute({this.txRef});

  final String? txRef;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final ref = txRef ?? state.uri.queryParameters['tx_ref'];
    return PaymentResultPage(txRef: ref ?? '');
  }
}
