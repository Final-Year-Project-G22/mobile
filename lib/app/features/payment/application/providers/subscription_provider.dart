import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/subscription.dart';
import 'payment_repository_provider.dart';

part 'subscription_provider.g.dart';

@riverpod
Future<Subscription?> subscription(Ref ref) async {
  final repo = ref.watch(paymentRepositoryProvider);
  final result = await repo.getMySubscription();
  return result.fold(
    (failure) => throw Exception(failure.toString()),
    (sub) => sub,
  );
}
