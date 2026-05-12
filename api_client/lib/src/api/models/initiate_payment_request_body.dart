// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'initiate_payment_request_body.freezed.dart';
part 'initiate_payment_request_body.g.dart';

@Freezed()
abstract class InitiatePaymentRequestBody with _$InitiatePaymentRequestBody {
  const factory InitiatePaymentRequestBody({
    /// Customer email
    required String email,

    /// Customer first name
    required String firstName,

    /// Customer last name
    required String lastName,

    /// Billing period (monthly or yearly)
    required String period,

    /// Plan name (Basic or Pro)
    required String planName,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Customer phone number (optional)
    String? phone,
  }) = _InitiatePaymentRequestBody;

  factory InitiatePaymentRequestBody.fromJson(Map<String, Object?> json) =>
      _$InitiatePaymentRequestBodyFromJson(json);
}
