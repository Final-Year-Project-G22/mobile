// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_response.freezed.dart';
part 'subscription_response.g.dart';

@Freezed()
abstract class SubscriptionResponse with _$SubscriptionResponse {
  const factory SubscriptionResponse({
    /// Amount in minor units
    required int amount,

    /// Currency code
    required String currency,

    /// Period end
    required DateTime currentPeriodEnd,

    /// Period start
    required DateTime currentPeriodStart,

    /// Subscription ID
    required String id,

    /// Plan name
    required String planName,

    /// Billing period
    required String planPeriod,

    /// Number of renewals
    required int renewalCount,

    /// Subscription status
    required String status,
  }) = _SubscriptionResponse;

  factory SubscriptionResponse.fromJson(Map<String, Object?> json) => _$SubscriptionResponseFromJson(json);
}
