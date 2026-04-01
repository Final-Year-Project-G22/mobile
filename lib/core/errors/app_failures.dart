sealed class Failure {
  const Failure({required this.message, this.code});
  final String message;
  final String? code;
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code, this.statusCode});
  final int? statusCode;
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.code});
}

class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code,
    this.fieldErrors,
  });
  final Map<String, String>? fieldErrors;
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, super.code});
}
