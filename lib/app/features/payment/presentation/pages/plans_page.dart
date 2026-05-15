import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/constants/app_colors.dart';
import '../../../../../app/router/routes.dart';
import '../../../../../core/l10n/generated/app_localizations.dart';
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

  static List<String> basicFeatures(AppLocalizations l10n) => [
    l10n.planFeatureAllGuides,
    l10n.planFeatureCommunity,
    l10n.planFeatureAiQuestions,
  ];

  static List<String> proFeatures(AppLocalizations l10n) => [
    l10n.planFeatureEverythingBasic,
    l10n.planFeatureUnlimitedAi,
    l10n.planFeatureTemplates,
    l10n.planFeatureSupport,
    l10n.planFeatureAdvancedProfile,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(plansProvider);
    final checkoutAsync = ref.watch(checkoutProvider);
    final authState = ref.watch(authProvider);
    final subAsync = ref.watch(subscriptionProvider);
    final l10n = AppLocalizations.of(context);

    ref.listen<AsyncValue<PaymentCheckout?>>(checkoutProvider, (prev, next) {
      next.whenOrNull(
        data: (checkout) {
          if (checkout != null) {
            debugPrint(
              '[PAYMENT] PlansPage navigating to checkout: url=${checkout.checkoutUrl}',
            );
            unawaited(
              context.push(
                CheckoutLauncherRoute(
                  url: checkout.checkoutUrl,
                  txRef: checkout.txRef,
                ).location,
              ),
            );
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
                label: l10n.ok,
                textColor: Colors.white,
                onPressed: () {},
              ),
            ),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: Text(l10n.chooseYourPlan)),
      body: Stack(
        children: [
          if (authState.isLoading ||
              authState.value?.user == null ||
              subAsync.isLoading)
            const Center(child: CircularProgressIndicator())
          else
            plansAsync.when(
              data: (plans) =>
                  _buildContent(context, ref, plans, subAsync.value, l10n),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) =>
                  Center(child: Text(l10n.failedToLoadPlans('$error'))),
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
    AppLocalizations l10n,
  ) {
    final hasPro =
        sub != null && sub.planName == 'Pro' && sub.status == 'active';
    final basicPlans = plans.where((p) => p.name == 'Basic').toList();
    final basicMonthly = basicPlans
        .where((p) => p.period == 'monthly')
        .firstOrNull;
    final proPlans = plans.where((p) => p.name == 'Pro').toList();
    final proMonthly = proPlans.where((p) => p.period == 'monthly').firstOrNull;
    final proYearly = proPlans.where((p) => p.period == 'yearly').firstOrNull;

    void handleSubscribe(String planName, String period) {
      debugPrint(
        '[PAYMENT] handleSubscribe called: plan=$planName, period=$period',
      );
      final authState = ref.read(authProvider);
      final isAuthenticated = authState.value?.isAuthenticated ?? false;
      if (!isAuthenticated) {
        debugPrint(
          '[PAYMENT] handleSubscribe: not authenticated, redirecting to login',
        );
        unawaited(context.push(const LoginRoute().location));
        return;
      }
      final user = authState.value?.user;
      final account = authState.value?.account;
      if (user == null || account == null) {
        debugPrint('[PAYMENT] handleSubscribe: user or account is null');
        return;
      }
      debugPrint(
        '[PAYMENT] handleSubscribe: user=${user.firstName}, email=${account.email}',
      );
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
                        Text(
                          l10n.youAreOnPro,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          l10n.activeUntil(
                            sub.currentPeriodEnd.toLocal().toString().split(
                              ' ',
                            )[0],
                          ),
                          style: const TextStyle(
                            color: AppColors.slate500,
                            fontSize: 12,
                          ),
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
              title: l10n.basic,
              price: _formatAmount(basicMonthly.amount),
              period: basicMonthly.amount == 0
                  ? l10n.freeForever
                  : l10n.perMonth,
              features: basicFeatures(l10n),
              currentPlan: !hasPro,
            ),
          const SizedBox(height: 16),
          if (proMonthly != null)
            PlanComparisonCard(
              title: l10n.proMonthly,
              price: _formatAmount(proMonthly.amount),
              period: l10n.perMonth,
              features: proFeatures(l10n),
              isPro: true,
              highlight: !hasPro,
              onSubscribe: hasPro
                  ? null
                  : () => handleSubscribe('Pro', 'monthly'),
              currentPlan: hasPro && sub.planPeriod == 'monthly',
            ),
          if (proYearly != null) ...[
            const SizedBox(height: 16),
            PlanComparisonCard(
              title: l10n.proYearly,
              price: _formatAmount(proYearly.amount),
              period: l10n.perYear,
              features: proFeatures(l10n),
              isPro: true,
              onSubscribe: hasPro
                  ? null
                  : () => handleSubscribe('Pro', 'yearly'),
              highlight:
                  _yearlySavings(proMonthly?.amount, proYearly.amount) > 0,
              currentPlan: hasPro && sub.planPeriod == 'yearly',
            ),
            if (_yearlySavings(proMonthly?.amount, proYearly.amount) > 0)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  l10n.savePercentYearly(
                    _yearlySavings(proMonthly?.amount, proYearly.amount),
                  ),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.success),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
          const SizedBox(height: 24),
          Text(
            l10n.billingDisclaimer,
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
