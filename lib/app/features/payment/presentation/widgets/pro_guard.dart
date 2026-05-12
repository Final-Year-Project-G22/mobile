import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/subscription_provider.dart';

class ProGuard extends ConsumerWidget {
  const ProGuard({required this.child, required this.fallback, super.key});
  final Widget child;
  final Widget fallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subAsync = ref.watch(subscriptionProvider);
    return subAsync.when(
      data: (sub) => (sub != null && sub.planName == 'Pro' && sub.status == 'active') ? child : fallback,
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => fallback,
    );
  }
}
