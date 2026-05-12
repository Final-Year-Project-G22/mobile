// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_payment_response_body.freezed.dart';
part 'verify_payment_response_body.g.dart';

@Freezed()
abstract class VerifyPaymentResponseBody with _$VerifyPaymentResponseBody {
  const factory VerifyPaymentResponseBody({
    /// Amount in minor units
    required int amount,

    /// Currency code
    required String currency,

    /// Plan name
    required String planName,

    /// Billing period
    required String planPeriod,

    /// Payment status
    required String status,

    /// Transaction reference
    required String txRef,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Chapa internal reference
    String? chapaRef,

    /// Payment method used
    String? paymentMethod,

    /// Verification timestamp
    String? verifiedAt,
  }) = _VerifyPaymentResponseBody;

  factory VerifyPaymentResponseBody.fromJson(Map<String, Object?> json) =>
      _$VerifyPaymentResponseBodyFromJson(json);
}
