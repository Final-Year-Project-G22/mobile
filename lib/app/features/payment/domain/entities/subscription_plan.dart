import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_plan.freezed.dart';

@freezed
abstract class SubscriptionPlan with _$SubscriptionPlan {
  const factory SubscriptionPlan({
    required String id,
    required String name,
    required String period,
    required int amount,
    required String currency,
    required bool isActive,
  }) = _SubscriptionPlan;
}
