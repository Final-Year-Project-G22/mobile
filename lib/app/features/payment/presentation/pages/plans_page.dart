import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/constants/app_colors.dart';
import '../../../auth/application/auth_notifier.dart';
import '../../application/providers/checkout_notifier.dart';
import '../../application/providers/plans_provider.dart';
import '../../domain/entities/payment_checkout.dart';
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

    ref.listen<AsyncValue<PaymentCheckout?>>(checkoutProvider, (prev, next) {
      next.whenOrNull(
        data: (checkout) {
          if (checkout != null) {
            unawaited(
              context.push('/checkout?url=${Uri.encodeComponent(checkout.checkoutUrl)}&txRef=${checkout.txRef}'),
            );
          }
        },
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Choose Your Plan')),
      body: plansAsync.when(
        data: (plans) => _buildContent(context, ref, plans),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Failed to load plans: $error')),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    List<SubscriptionPlan> plans,
  ) {
    final proPlans = plans.where((p) => p.name == 'Pro').toList();
    final proMonthly = proPlans.where((p) => p.period == 'monthly').firstOrNull;
    final proYearly = proPlans.where((p) => p.period == 'yearly').firstOrNull;

    void handleSubscribe(String planName, String period) {
      final authState = ref.read(authProvider);
      final isAuthenticated = authState.value?.isAuthenticated ?? false;
      if (!isAuthenticated) {
        unawaited(context.push('/login'));
        return;
      }
      unawaited(ref.read(checkoutProvider.notifier).initiate(planName, period));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const PlanComparisonCard(
            title: 'Basic',
            price: 'Free',
            period: 'forever',
            features: _basicFeatures,
          ),
          const SizedBox(height: 16),
          if (proMonthly != null)
            PlanComparisonCard(
              title: 'Pro Monthly',
              price: _formatAmount(proMonthly.amount),
              period: '/month',
              features: _proFeatures,
              isPro: true,
              highlight: true,
              onSubscribe: () => handleSubscribe('Pro', 'monthly'),
            ),
          if (proYearly != null) ...[
            const SizedBox(height: 16),
            PlanComparisonCard(
              title: 'Pro Yearly',
              price: _formatAmount(proYearly.amount),
              period: '/year',
              features: _proFeatures,
              isPro: true,
              onSubscribe: () => handleSubscribe('Pro', 'yearly'),
              highlight: _yearlySavings(proMonthly?.amount, proYearly.amount) > 0,
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
