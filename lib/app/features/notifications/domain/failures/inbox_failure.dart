import 'package:freezed_annotation/freezed_annotation.dart';

part 'inbox_failure.freezed.dart';

@freezed
class InboxFailure with _$InboxFailure {
  const factory InboxFailure.serverError([String? message]) = ServerError;
  const factory InboxFailure.notFound() = NotFound;
  const factory InboxFailure.unauthorized() = Unauthorized;
  const factory InboxFailure.invalidData([String? message]) = InvalidData;
  const factory InboxFailure.networkError() = NetworkError;
}
