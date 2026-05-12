import 'package:dartz/dartz.dart';

import 'entities/payment_checkout.dart';
import 'entities/payment_verification.dart';
import 'entities/subscription.dart';
import 'entities/subscription_plan.dart';
import 'failures/payment_failure.dart';

abstract class IPaymentRepository {
  Future<Either<PaymentFailure, List<SubscriptionPlan>>> getPlans();
  Future<Either<PaymentFailure, PaymentCheckout>> initiatePayment({
    required String planName,
    required String period,
    required String email,
    required String firstName,
    required String lastName,
    String? phone,
  });
  Future<Either<PaymentFailure, PaymentVerification>> verifyPayment(
    String txRef,
  );
  Future<Either<PaymentFailure, Subscription?>> getMySubscription();
}
