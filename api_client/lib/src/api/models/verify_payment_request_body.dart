// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_payment_request_body.freezed.dart';
part 'verify_payment_request_body.g.dart';

@Freezed()
abstract class VerifyPaymentRequestBody with _$VerifyPaymentRequestBody {
  const factory VerifyPaymentRequestBody({
    /// Transaction reference to verify
    required String txRef,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _VerifyPaymentRequestBody;

  factory VerifyPaymentRequestBody.fromJson(Map<String, Object?> json) => _$VerifyPaymentRequestBodyFromJson(json);
}
