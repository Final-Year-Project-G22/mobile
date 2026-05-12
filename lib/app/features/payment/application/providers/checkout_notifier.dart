import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/payment_checkout.dart';
import 'payment_repository_provider.dart';
import 'pending_payment_provider.dart';

part 'checkout_notifier.g.dart';

@riverpod
class CheckoutNotifier extends _$CheckoutNotifier {
  @override
  Future<PaymentCheckout?> build() async => null;

  Future<void> initiate(String planName, String period) async {
    state = const AsyncLoading();
    final repo = ref.read(paymentRepositoryProvider);

    state = await AsyncValue.guard(() async {
      final result = await repo.initiatePayment(planName, period);
      final checkout = result.getOrElse(() => throw Exception('Failed to initiate payment'));
      await ref.read(pendingPaymentProvider.notifier).set(checkout.txRef);
      return checkout;
    });
  }
}
