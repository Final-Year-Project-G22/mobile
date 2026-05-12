import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_verification.freezed.dart';

@freezed
abstract class PaymentVerification with _$PaymentVerification {
  const factory PaymentVerification({
    required String txRef,
    required String chapaRef,
    required String status,
    required int amount,
    required String currency,
    required String planName,
    required String planPeriod,
    required String paymentMethod,
    required DateTime? verifiedAt,
  }) = _PaymentVerification;
}
