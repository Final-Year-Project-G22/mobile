import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/subscription_plan.dart';
import 'payment_repository_provider.dart';

part 'plans_provider.g.dart';

@riverpod
Future<List<SubscriptionPlan>> plans(Ref ref) async {
  final repo = ref.watch(paymentRepositoryProvider);
  final result = await repo.getPlans();
  return result.fold(
    (failure) => throw Exception(failure.toString()),
    (plans) => plans,
  );
}
