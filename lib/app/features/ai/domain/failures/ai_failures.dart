import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_failures.freezed.dart';

@freezed
class AiFailure with _$AiFailure {
  const factory AiFailure.streamError([String? message]) = StreamError;
  const factory AiFailure.networkError() = NetworkError;
  const factory AiFailure.serverError([String? message]) = ServerError;
  const factory AiFailure.notFound() = NotFound;
  const factory AiFailure.unauthorized() = Unauthorized;
}
