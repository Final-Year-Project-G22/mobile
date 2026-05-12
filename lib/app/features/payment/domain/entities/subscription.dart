import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription.freezed.dart';

@freezed
abstract class Subscription with _$Subscription {
  const factory Subscription({
    required String id,
    required String planName,
    required String planPeriod,
    required int amount,
    required String currency,
    required String status,
    required DateTime currentPeriodStart,
    required DateTime currentPeriodEnd,
    required int renewalCount,
  }) = _Subscription;
}
