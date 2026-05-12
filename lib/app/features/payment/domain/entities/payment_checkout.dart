import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_checkout.freezed.dart';

@freezed
abstract class PaymentCheckout with _$PaymentCheckout {
  const factory PaymentCheckout({
    required String txRef,
    required String checkoutUrl,
    required int amount,
    required String currency,
    required String planName,
    required String period,
    required DateTime expiresAt,
  }) = _PaymentCheckout;
}
