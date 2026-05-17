import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../app/router/routes.dart';
import '../../../../../core/l10n/generated/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: resultAsync.when(
        data: (verification) => _buildResult(context, verification, l10n),
        loading: () => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(l10n.verifyingPayment),
            ],
          ),
        ),
        error: (error, _) => _buildError(context, error.toString(), l10n),
      ),
    );
  }

  Widget _buildResult(
    BuildContext context,
    PaymentVerification? verification,
    AppLocalizations l10n,
  ) {
    if (verification == null) {
      return _buildError(context, l10n.noVerificationResult, l10n);
    }

    switch (verification.status) {
      case 'success':
        return _buildSuccess(context, l10n);
      case 'pending':
        return _buildPending(context, l10n);
      default:
        return _buildFailed(context, l10n);
    }
  }

  Widget _buildSuccess(BuildContext context, AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 80, color: colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              l10n.paymentSuccessful,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.proPlanActive,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () => context.go('/home'),
              child: Text(l10n.continueText),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPending(BuildContext context, AppLocalizations l10n) {
    ref.read(paymentResultProvider.notifier).startPolling(widget.txRef);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              l10n.paymentProcessing,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.paymentBeingProcessed,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFailed(BuildContext context, AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cancel, size: 80, color: colorScheme.error),
            const SizedBox(height: 16),
            Text(
              l10n.paymentFailed,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.couldNotCompletePayment,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: () => context.replace(const PlansRoute().location),
              child: Text(l10n.tryAgain),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(
    BuildContext context,
    String message,
    AppLocalizations l10n,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.hourglass_empty,
              size: 80,
              color: colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => context.go(const HomeRoute().location),
              child: Text(l10n.backToHome),
            ),
          ],
        ),
      ),
    );
  }
}
