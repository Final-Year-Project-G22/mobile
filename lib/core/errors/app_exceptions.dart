import 'package:dio/dio.dart';
import 'package:api_client/api_client.dart';

class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic data;

  const AppException({required this.message, this.code, this.data});

  @override
  String toString() => 'AppException: $message ($code)';
}

class NetworkException extends AppException {
  const NetworkException({required super.message, super.code});
}

class ServerException extends AppException {
  final int? statusCode;

  const ServerException({required super.message, super.code, this.statusCode, super.data});
}

class AuthException extends AppException {
  const AuthException({required super.message, super.code});
}

class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException({required super.message, super.code, this.fieldErrors});
}

class CacheException extends AppException {
  const CacheException({required super.message, super.code});
}

class UnknownException extends AppException {
  const UnknownException({required super.message, super.code});
}

class AppExceptionMapper {
  static AppException fromApiException(ApiException e) {
    if (e.statusCode == 401) {
      return AuthException(message: e.message, code: e.errorCode);
    }
    if (e.statusCode == 400) {
      final errors = e.data is Map<String, dynamic> ? e.data['errors'] as Map<String, dynamic>? : null;
      if (errors != null) {
        return ValidationException(
          message: e.message,
          code: e.errorCode,
          fieldErrors: errors.map((k, v) => MapEntry(k, v.toString())),
        );
      }
      return ValidationException(message: e.message, code: e.errorCode);
    }
    if (e.statusCode == null || e.statusCode == 0) {
      return NetworkException(message: e.message, code: e.statusCode?.toString());
    }
    return ServerException(message: e.message, code: e.errorCode, statusCode: e.statusCode, data: e.data);
  }

  static AppException fromDioException(DioException e) {
    return fromApiException(ApiException.fromDioError(e));
  }
}
