import 'package:api_client/api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../domain/entities/payment_checkout.dart';
import '../domain/entities/payment_verification.dart';
import '../domain/entities/subscription.dart';
import '../domain/entities/subscription_plan.dart';
import '../domain/failures/payment_failure.dart';
import '../domain/i_payment_repository.dart';

class PaymentRepositoryImpl implements IPaymentRepository {
  const PaymentRepositoryImpl(this._client);

  final PaymentsClient _client;

  @override
  Future<Either<PaymentFailure, List<SubscriptionPlan>>> getPlans() async {
    try {
      final response = await _client.listPlans();
      final plans = (response.data.data ?? [])
          .map((e) => PlanResponse.fromJson(e as Map<String, Object?>))
          .map(_mapPlanToDomain)
          .toList();
      return Right(plans);
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    } on Exception {
      return const Left(PaymentFailure.serverError());
    }
  }

  @override
  Future<Either<PaymentFailure, PaymentCheckout>> initiatePayment({
    required String planName,
    required String period,
    required String email,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    try {
      final response = await _client.initiatePayment(
        body: InitiatePaymentRequestBody(
          planName: planName,
          period: period,
          email: email,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
        ),
      );
      if (kDebugMode) {
        debugPrint(
          '[PAYMENT] initiatePayment response: status=${response.response.statusCode}, data=${response.data}',
        );
      }
      final checkout = _mapCheckoutToDomain(response.data);
      if (kDebugMode) {
        debugPrint(
          '[PAYMENT] mapped checkout: txRef=${checkout.txRef}, url=${checkout.checkoutUrl}',
        );
      }
      return Right(checkout);
    } on DioException catch (e) {
      if (kDebugMode) {
        debugPrint(
          '[PAYMENT] initiatePayment DioException: status=${e.response?.statusCode}, data=${e.response?.data}',
        );
      }
      return Left(_mapDioError(e));
    } on Exception catch (e) {
      if (kDebugMode) debugPrint('[PAYMENT] initiatePayment Exception: $e');
      return const Left(PaymentFailure.serverError());
    }
  }

  @override
  Future<Either<PaymentFailure, PaymentVerification>> verifyPayment(
    String txRef,
  ) async {
    try {
      final response = await _client.verifyPayment(
        body: VerifyPaymentRequestBody(txRef: txRef),
      );
      final verification = _mapVerificationToDomain(response.data);
      return Right(verification);
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    } on Exception {
      return const Left(PaymentFailure.serverError());
    }
  }

  @override
  Future<Either<PaymentFailure, Subscription?>> getMySubscription() async {
    try {
      final response = await _client.getMySubscription();
      final dto = response.data.data;
      return Right(dto != null ? _mapSubscriptionToDomain(dto) : null);
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    } on Exception {
      return const Left(PaymentFailure.serverError());
    }
  }

  PaymentFailure _mapDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionError:
        return const PaymentFailure.networkError();
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final data = error.response?.data;
        final detail = data is Map<String, dynamic>
            ? data['detail'] as String?
            : null;

        if (statusCode == 409) {
          return const PaymentFailure.alreadyPaid();
        } else if (statusCode == 404) {
          return const PaymentFailure.notFound();
        } else if (statusCode == 422) {
          return PaymentFailure.invalidData(detail);
        }
        return PaymentFailure.serverError(detail);
      case DioExceptionType.cancel:
        return const PaymentFailure.cancelled();
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return const PaymentFailure.serverError();
    }
  }

  SubscriptionPlan _mapPlanToDomain(PlanResponse dto) {
    return SubscriptionPlan(
      id: dto.id,
      name: dto.name,
      period: dto.period,
      amount: dto.amount,
      currency: dto.currency,
      isActive: dto.isActive,
    );
  }

  PaymentCheckout _mapCheckoutToDomain(InitiatePaymentResponseBody dto) {
    return PaymentCheckout(
      txRef: dto.txRef,
      checkoutUrl: dto.checkoutUrl,
      amount: dto.amount,
      currency: dto.currency,
      planName: dto.planName,
      period: dto.period,
      expiresAt: DateTime.fromMillisecondsSinceEpoch(dto.expiresAt * 1000),
    );
  }

  PaymentVerification _mapVerificationToDomain(VerifyPaymentResponseBody dto) {
    return PaymentVerification(
      txRef: dto.txRef,
      chapaRef: dto.chapaRef ?? '',
      status: dto.status,
      amount: dto.amount,
      currency: dto.currency,
      planName: dto.planName,
      planPeriod: dto.planPeriod,
      paymentMethod: dto.paymentMethod ?? '',
      verifiedAt: dto.verifiedAt != null
          ? DateTime.tryParse(dto.verifiedAt!)
          : null,
    );
  }

  Subscription _mapSubscriptionToDomain(SubscriptionResponse dto) {
    return Subscription(
      id: dto.id,
      planName: dto.planName,
      planPeriod: dto.planPeriod,
      amount: dto.amount,
      currency: dto.currency,
      status: dto.status,
      currentPeriodStart: dto.currentPeriodStart,
      currentPeriodEnd: dto.currentPeriodEnd,
      renewalCount: dto.renewalCount,
    );
  }
}
