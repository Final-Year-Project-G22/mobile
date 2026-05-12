import 'dart:async';
import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/payment_verification.dart';
import 'payment_repository_provider.dart';
import 'pending_payment_provider.dart';
import 'subscription_provider.dart';

part 'payment_result_notifier.g.dart';

@riverpod
class PaymentResultNotifier extends _$PaymentResultNotifier {
  Timer? _timer;
  int _attempts = 0;

  @override
  Future<PaymentVerification?> build() async {
    ref.onDispose(() => _timer?.cancel());
    return null;
  }

  Future<void> verify(String txRef) async {
    state = const AsyncLoading();
    final repo = ref.read(paymentRepositoryProvider);

    state = await AsyncValue.guard(() async {
      final result = await repo.verifyPayment(txRef);
      final verification = result.getOrElse(
        () => throw Exception('Failed to verify payment'),
      );

      if (verification.status == 'success' || verification.status == 'failed') {
        await ref.read(pendingPaymentProvider.notifier).clear();
        ref.invalidate(subscriptionProvider);
      }
      return verification;
    });
  }

  void startPolling(String txRef, {int maxAttempts = 10}) {
    _timer?.cancel();
    _attempts = 0;

    void tick() {
      if (_attempts >= maxAttempts) {
        _timer?.cancel();
        state = AsyncError(
          'Payment is still processing. We will notify you when it completes.',
          StackTrace.current,
        );
        return;
      }
      _attempts++;
      unawaited(verify(txRef));
      final current = state.value;
      if (current != null &&
          (current.status == 'success' || current.status == 'failed')) {
        _timer?.cancel();
        return;
      }
      final delay = Duration(seconds: pow(2, _attempts).clamp(2, 60).toInt());
      _timer = Timer(delay, tick);
    }

    tick();
  }
}
