import 'exceptions.dart';

sealed class Failure {
  final String message;
  final int? code;

  const Failure({required this.message, this.code});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.code});
}

class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure({required super.message, super.code, this.fieldErrors});
}

class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, super.code});
}

extension FailureMapper on Failure {
  static Failure fromApiException(ApiException e) {
    if (e.statusCode == 401) {
      return AuthFailure(message: e.message, code: e.statusCode);
    }
    if (e.statusCode == 400) {
      final errors = e.data is Map<String, dynamic> ? e.data['errors'] as Map<String, dynamic>? : null;
      if (errors != null) {
        return ValidationFailure(
          message: e.message,
          code: e.statusCode,
          fieldErrors: errors.map((k, v) => MapEntry(k, v.toString())),
        );
      }
      return ValidationFailure(message: e.message, code: e.statusCode);
    }
    if (e.statusCode == null || e.statusCode == 0) {
      return NetworkFailure(message: e.message, code: e.statusCode);
    }
    if (e.statusCode! >= 500) {
      return ServerFailure(message: e.message, code: e.statusCode);
    }
    return ServerFailure(message: e.message, code: e.statusCode);
  }
}
