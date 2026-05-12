import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;
  final String? errorCode;

  const ApiException({
    required this.message,
    this.statusCode,
    this.data,
    this.errorCode,
  });

  factory ApiException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiException(
          message: 'Connection timeout. Please check your internet.',
          statusCode: null,
        );
      case DioExceptionType.connectionError:
        return const ApiException(
          message: 'No internet connection.',
          statusCode: null,
        );
      case DioExceptionType.badResponse:
        return _parseResponseError(error.response);
      case DioExceptionType.cancel:
        return const ApiException(
          message: 'Request was cancelled.',
          statusCode: null,
        );
      case DioExceptionType.unknown:
        return ApiException(
          message: error.message ?? 'An unexpected error occurred',
          statusCode: error.response?.statusCode,
        );
      default:
        return ApiException(
          message: error.message ?? 'An unexpected error occurred',
          statusCode: error.response?.statusCode,
        );
    }
  }

  static ApiException _parseResponseError(Response? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;

    String message = 'An error occurred';
    String? errorCode;

    if (data is Map<String, dynamic>) {
      message =
          data['message'] as String? ?? data['error'] as String? ?? message;
      errorCode = data['code'] as String?;
    }

    switch (statusCode) {
      case 400:
        message = message.isEmpty ? 'Bad request' : message;
        break;
      case 401:
        message = 'Unauthorized. Please login again.';
        break;
      case 403:
        message = 'Access denied.';
        break;
      case 404:
        message = 'Resource not found.';
        break;
      case 422:
        message = message.isEmpty ? 'Validation error' : message;
        break;
      case 500:
      case 502:
      case 503:
        message = 'Server error. Please try again later.';
        break;
    }

    return ApiException(
      message: message,
      statusCode: statusCode,
      data: data,
      errorCode: errorCode,
    );
  }

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

class TokenExpiredException extends ApiException {
  const TokenExpiredException()
    : super(message: 'Session expired. Please login again.', statusCode: 401);
}

class NetworkException extends ApiException {
  const NetworkException({String? message})
    : super(message: message ?? 'No internet connection.', statusCode: null);
}
