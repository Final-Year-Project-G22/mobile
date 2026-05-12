import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/constants/app_colors.dart';
import '../../../../../app/router/routes.dart';
import '../../application/providers/payment_result_notifier.dart';
import '../../domain/entities/payment_verification.dart';

class PaymentResultPage extends ConsumerStatefulWidget {
  const PaymentResultPage({required this.txRef, super.key});

  final String txRef;

  @override
  ConsumerState<PaymentResultPage> createState() => _PaymentResultPageState();
}

class _PaymentResultPageState extends ConsumerState<PaymentResultPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(ref.read(paymentResultProvider.notifier).verify(widget.txRef));
    });
  }

  @override
  Widget build(BuildContext context) {
    final resultAsync = ref.watch(paymentResultProvider);

    return Scaffold(
      appBar: AppBar(),
      body: resultAsync.when(
        data: (verification) => _buildResult(context, verification),
        loading: () => const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Verifying your payment...'),
            ],
          ),
        ),
        error: (error, _) => _buildError(context, error.toString()),
      ),
    );
  }

  Widget _buildResult(BuildContext context, PaymentVerification? verification) {
    if (verification == null) {
      return _buildError(context, 'No verification result');
    }

    switch (verification.status) {
      case 'success':
        return _buildSuccess(context);
      case 'pending':
        return _buildPending(context);
      default:
        return _buildFailed(context);
    }
  }

  Widget _buildSuccess(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, size: 80, color: AppColors.success),
            const SizedBox(height: 16),
            Text(
              'Payment Successful',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Your Pro plan is now active.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.accent,
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () => context.go('/home'),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPending(BuildContext context) {
    ref.read(paymentResultProvider.notifier).startPolling(widget.txRef);

    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Payment Processing',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'Your payment is being processed by your bank. '
              'This may take a moment.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFailed(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cancel, size: 80, color: AppColors.error),
            const SizedBox(height: 16),
            Text(
              'Payment Failed',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Your payment could not be completed.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () => context.replace(const PlansRoute().location),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.hourglass_empty,
              size: 80,
              color: AppColors.warning,
            ),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => context.go(const HomeRoute().location),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
