import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/constants/app_colors.dart';
import '../../../../../app/router/routes.dart';
import '../../../auth/application/auth_notifier.dart';
import '../../application/providers/checkout_notifier.dart';
import '../../application/providers/plans_provider.dart';
import '../../application/providers/subscription_provider.dart';
import '../../domain/entities/payment_checkout.dart';
import '../../domain/entities/subscription.dart';
import '../../domain/entities/subscription_plan.dart';
import '../widgets/plan_comparison_card.dart';

class PlansPage extends ConsumerWidget {
  const PlansPage({super.key});

  static const _basicFeatures = [
    'Access to all guides',
    'Community read-only access',
    '3 AI questions per month',
  ];

  static const _proFeatures = [
    'Everything in Basic',
    'Unlimited AI questions',
    'Template downloads',
    'Priority community support',
    'Advanced business profile',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(plansProvider);
    final checkoutAsync = ref.watch(checkoutProvider);
    final authState = ref.watch(authProvider);
    final subAsync = ref.watch(subscriptionProvider);

    ref.listen<AsyncValue<PaymentCheckout?>>(checkoutProvider, (prev, next) {
      next.whenOrNull(
        data: (checkout) {
          if (checkout != null) {
            debugPrint('[PAYMENT] PlansPage navigating to checkout: url=${checkout.checkoutUrl}');
            unawaited(context.push(CheckoutLauncherRoute(url: checkout.checkoutUrl, txRef: checkout.txRef).location));
          }
        },
        error: (error, _) {
          debugPrint('[PAYMENT] PlansPage checkout error: $error');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 8),
              action: SnackBarAction(
                label: 'OK',
                textColor: Colors.white,
                onPressed: () {},
              ),
            ),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Choose Your Plan')),
      body: Stack(
        children: [
          if (authState.isLoading || authState.value?.user == null || subAsync.isLoading)
            const Center(child: CircularProgressIndicator())
          else
            plansAsync.when(
              data: (plans) => _buildContent(context, ref, plans, subAsync.value),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('Failed to load plans: $error')),
            ),
          if (checkoutAsync.isLoading)
            const ColoredBox(
              color: Colors.black26,
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    List<SubscriptionPlan> plans,
    Subscription? sub,
  ) {
    final hasPro = sub != null && sub.planName == 'Pro' && sub.status == 'active';
    final basicPlans = plans.where((p) => p.name == 'Basic').toList();
    final basicMonthly = basicPlans.where((p) => p.period == 'monthly').firstOrNull;
    final proPlans = plans.where((p) => p.name == 'Pro').toList();
    final proMonthly = proPlans.where((p) => p.period == 'monthly').firstOrNull;
    final proYearly = proPlans.where((p) => p.period == 'yearly').firstOrNull;

    void handleSubscribe(String planName, String period) {
      debugPrint('[PAYMENT] handleSubscribe called: plan=$planName, period=$period');
      final authState = ref.read(authProvider);
      final isAuthenticated = authState.value?.isAuthenticated ?? false;
      if (!isAuthenticated) {
        debugPrint('[PAYMENT] handleSubscribe: not authenticated, redirecting to login');
        unawaited(context.push(const LoginRoute().location));
        return;
      }
      final user = authState.value?.user;
      final account = authState.value?.account;
      if (user == null || account == null) {
        debugPrint('[PAYMENT] handleSubscribe: user or account is null');
        return;
      }
      debugPrint('[PAYMENT] handleSubscribe: user=${user.firstName}, email=${account.email}');
      unawaited(
        ref
            .read(checkoutProvider.notifier)
            .initiate(
              planName: planName,
              period: period,
              email: account.email,
              firstName: user.firstName,
              lastName: user.lastName,
            ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (hasPro)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.success.withAlpha(25),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.success.withAlpha(80)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: AppColors.success),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('You are on Pro', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                          'Active until ${sub.currentPeriodEnd.toLocal().toString().split(' ')[0]}',
                          style: const TextStyle(color: AppColors.slate500, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          if (basicMonthly != null)
            PlanComparisonCard(
              title: 'Basic',
              price: _formatAmount(basicMonthly.amount),
              period: basicMonthly.amount == 0 ? 'free forever' : '/month',
              features: _basicFeatures,
              currentPlan: !hasPro,
            ),
          const SizedBox(height: 16),
          if (proMonthly != null)
            PlanComparisonCard(
              title: 'Pro Monthly',
              price: _formatAmount(proMonthly.amount),
              period: '/month',
              features: _proFeatures,
              isPro: true,
              highlight: !hasPro,
              onSubscribe: hasPro ? null : () => handleSubscribe('Pro', 'monthly'),
              currentPlan: hasPro && sub.planPeriod == 'monthly',
            ),
          if (proYearly != null) ...[
            const SizedBox(height: 16),
            PlanComparisonCard(
              title: 'Pro Yearly',
              price: _formatAmount(proYearly.amount),
              period: '/year',
              features: _proFeatures,
              isPro: true,
              onSubscribe: hasPro ? null : () => handleSubscribe('Pro', 'yearly'),
              highlight: _yearlySavings(proMonthly?.amount, proYearly.amount) > 0,
              currentPlan: hasPro && sub.planPeriod == 'yearly',
            ),
            if (_yearlySavings(proMonthly?.amount, proYearly.amount) > 0)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Save ${_yearlySavings(proMonthly?.amount, proYearly.amount)}% with yearly billing',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.success),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
          const SizedBox(height: 24),
          Text(
            'Subscriptions are billed in ETB. You can cancel anytime.',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.slate400),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatAmount(int minorUnits) {
    final birr = minorUnits / 100;
    return '$birr ETB';
  }

  int _yearlySavings(int? monthlyAmount, int? yearlyAmount) {
    if (monthlyAmount == null || yearlyAmount == null) return 0;
    final monthlyAnnual = monthlyAmount * 12;
    if (monthlyAnnual <= yearlyAmount) return 0;
    return ((monthlyAnnual - yearlyAmount) / monthlyAnnual * 100).round();
  }
}
