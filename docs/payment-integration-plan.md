# Flutter Payment Integration — Implementation Plan

## Architecture Decision

| Decision | Choice |
|---|---|
| Checkout mechanism | `flutter_web_auth_2` (Custom Tabs / ASWebAuthenticationSession) |
| Return flow | Deep link `adisu://payment/success` |
| Fallback | `app_links` listener + GoRouter native deep link |
| On cancel | Return to PlansPage with SnackBar "Payment cancelled" |
| Plans display | Comparison: Basic (Free) vs Pro monthly/yearly |
| Navigation entry | Settings "Subscription" row + Profile Pro badge |
| Plans route | Public (accessible without auth) |

## Phase Summary

| # | Phase | Files | Est. |
|---|---|---|---|
| 1 | API Client Registration | 1 | 2 min |
| 2 | Domain Layer | 6 source + 5 generated | 5 min |
| 3 | Infrastructure Layer | 1 | 5 min |
| 4 | Application Layer (Riverpod) | 6 source + 6 generated | 10 min |
| 5 | Presentation Layer | 5 | 15 min |
| 6 | Routing & Deep Links | 3 | 10 min |
| 7 | Entitlement Gating & Entry Points | 4 | 10 min |
| 8 | Testing & Polish | — | 20 min |

## File Inventory

```
api_client/lib/api_client.dart                                # modified — add exports
lib/app/features/payment/domain/
├── entities/subscription_plan.dart
├── entities/payment_checkout.dart
├── entities/payment_verification.dart
├── entities/subscription.dart
├── failures/payment_failure.dart
└── i_payment_repository.dart
lib/app/features/payment/infrastructure/
└── payment_repository_impl.dart
lib/app/features/payment/application/providers/
├── payment_repository_provider.dart
├── plans_provider.dart
├── subscription_provider.dart
├── checkout_notifier.dart
├── payment_result_notifier.dart
└── pending_payment_provider.dart
lib/app/features/payment/presentation/
├── pages/plans_page.dart
├── pages/checkout_launcher_page.dart
├── pages/payment_result_page.dart
└── widgets/
    ├── plan_comparison_card.dart
    └── pro_guard.dart
lib/app/router/routes.dart                                    # modified
lib/app/router/app_router.dart                                # modified
lib/core/deep_link_listener.dart                              # new
lib/app/features/settings/presentation/pages/settings_page.dart  # modified
lib/app/features/profile/presentation/pages/profile_page.dart    # modified
lib/app/features/templates/presentation/pages/template_detail_page.dart  # modified
lib/main.dart                                                 # modified — wrap with DeepLinkListener
```

## Checkout Flow

```
PlansPage → CheckoutNotifier.initiate()
    ↓
Backend /api/v1/payments/initiate → { checkoutUrl, txRef }
    ↓
Persist txRef → SharedPreferences (pending_payment_provider)
    ↓
CheckoutLauncherPage → FlutterWebAuth2.authenticate(url: checkoutUrl)
    ↓
User completes payment in Chapa Custom Tab
    ↓
Chapa redirects → adisu://payment/success?tx_ref=xxx
    ↓
FlutterWebAuth2 returns result → PaymentResultPage
    ↓
POST /api/v1/payments/verify → status: success/pending/failed
    ├── success → Clear pending txRef → Invalidate subscription provider → Home
    ├── pending → Exponential backoff polling (max 10 attempts, up to ~17 min)
    └── failed → Show error + Try Again button
```
