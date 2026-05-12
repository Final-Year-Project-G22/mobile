// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/get_my_subscription_response_body.dart';
import '../models/initiate_payment_request_body.dart';
import '../models/initiate_payment_response_body.dart';
import '../models/list_plans_response_body.dart';
import '../models/verify_payment_request_body.dart';
import '../models/verify_payment_response_body.dart';

part 'payments_client.g.dart';

@RestApi()
abstract class PaymentsClient {
  factory PaymentsClient(Dio dio, {String? baseUrl}) = _PaymentsClient;

  /// Get my subscription.
  ///
  /// Returns the current account's active subscription.
  @GET('/api/v1/me/subscription')
  Future<HttpResponse<GetMySubscriptionResponseBody>> getMySubscription();

  /// Initiate payment.
  ///
  /// Starts a new payment transaction and returns a Chapa checkout URL.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/payments/initiate')
  Future<HttpResponse<InitiatePaymentResponseBody>> initiatePayment({
    @Body() required InitiatePaymentRequestBody body,
  });

  /// List subscription plans.
  ///
  /// Returns all available subscription plans.
  @GET('/api/v1/payments/plans')
  Future<HttpResponse<ListPlansResponseBody>> listPlans();

  /// Verify payment.
  ///
  /// Verifies the status of a payment by transaction reference.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/payments/verify')
  Future<HttpResponse<VerifyPaymentResponseBody>> verifyPayment({
    @Body() required VerifyPaymentRequestBody body,
  });
}
