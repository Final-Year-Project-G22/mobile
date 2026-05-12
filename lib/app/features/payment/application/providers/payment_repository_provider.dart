import 'package:api_client/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/di/infra_providers.dart';
import '../../domain/i_payment_repository.dart';
import '../../infrastructure/payment_repository_impl.dart';

part 'payment_repository_provider.g.dart';

@riverpod
IPaymentRepository paymentRepository(Ref ref) {
  final apiClient = ref.read(apiClientProvider);
  return PaymentRepositoryImpl(PaymentsClient(apiClient.dio));
}
