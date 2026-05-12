// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'initiate_payment_response_body.freezed.dart';
part 'initiate_payment_response_body.g.dart';

@Freezed()
abstract class InitiatePaymentResponseBody with _$InitiatePaymentResponseBody {
  const factory InitiatePaymentResponseBody({
    /// Amount in minor units
    required int amount,

    /// Chapa checkout URL
    required String checkoutUrl,

    /// Currency code
    required String currency,

    /// Checkout URL expiration (Unix timestamp)
    required int expiresAt,

    /// Billing period
    required String period,

    /// Plan name
    required String planName,

    /// Transaction reference
    required String txRef,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _InitiatePaymentResponseBody;

  factory InitiatePaymentResponseBody.fromJson(Map<String, Object?> json) =>
      _$InitiatePaymentResponseBodyFromJson(json);
}
