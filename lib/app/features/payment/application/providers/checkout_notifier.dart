import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/payment_checkout.dart';
import '../../domain/failures/payment_failure.dart';
import 'payment_repository_provider.dart';
import 'pending_payment_provider.dart';

part 'checkout_notifier.g.dart';

@riverpod
class CheckoutNotifier extends _$CheckoutNotifier {
  @override
  Future<PaymentCheckout?> build() async => null;

  Future<void> initiate({
    required String planName,
    required String period,
    required String email,
    required String firstName,
    required String lastName,
    String? phone,
  }) async {
    if (kDebugMode) {
      debugPrint(
        '[PAYMENT] CheckoutNotifier.initiate called: plan=$planName, period=$period',
      );
    }
    state = const AsyncLoading();
    final repo = ref.read(paymentRepositoryProvider);

    state = await AsyncValue.guard(() async {
      final result = await repo.initiatePayment(
        planName: planName,
        period: period,
        email: email,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
      );
      return result.fold(
        (failure) {
          final msg = failure.when(
            serverError: (msg) => msg ?? 'Server error. Please try again.',
            notFound: () => 'Plan not found.',
            alreadyPaid: () => 'You already have an active subscription.',
            networkError: () => 'Network error. Check your connection.',
            invalidData: (msg) => msg ?? 'Invalid payment request.',
            cancelled: () => 'Payment cancelled.',
          );
          if (kDebugMode)
            debugPrint('[PAYMENT] CheckoutNotifier FAILURE: $msg');
          throw Exception(msg);
        },
        (checkout) async {
          if (kDebugMode) {
            debugPrint(
              '[PAYMENT] CheckoutNotifier SUCCESS: txRef=${checkout.txRef}',
            );
          }
          await ref.read(pendingPaymentProvider.notifier).set(checkout.txRef);
          return checkout;
        },
      );
    });
  }
}
