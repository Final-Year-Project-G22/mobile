import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_failure.freezed.dart';

@freezed
abstract class PaymentFailure with _$PaymentFailure {
  const factory PaymentFailure.serverError([String? message]) = ServerError;
  const factory PaymentFailure.notFound() = NotFound;
  const factory PaymentFailure.alreadyPaid() = AlreadyPaid;
  const factory PaymentFailure.networkError() = NetworkError;
  const factory PaymentFailure.invalidData([String? message]) = InvalidData;
  const factory PaymentFailure.cancelled() = Cancelled;
}
