import 'package:api_client/api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mobile/features/auth/domain/entities/auth_response.dart';
import 'package:mobile/features/auth/domain/failures/auth_user_failure.dart';
import 'package:mobile/features/auth/domain/i_auth_repository.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthenticationClient _client;

  const AuthRepositoryImpl(this._client);

  @override
  Future<Either<AuthUserFailure, AuthResponse>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      print('inside reposityr');
      print(
        'RegisterRequest: ${RegisterRequest(email: email, password: password, firstName: firstName, lastName: lastName).toJson()}',
      );
      final response = await _client.register(
        body: RegisterRequest(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
        ),
      );
      return Right(
        AuthResponse(
          accessToken: response.accessToken,
          expiresAt: response.expiresAt,
          user: AuthUser(
            id: response.user.id,
            firstName: response.user.firstName,
            lastName: response.user.lastName,
          ),
          account: AuthAccount(
            id: response.account.id,
            email: response.account.email,
            status: response.account.status,
          ),
        ),
      );
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return const Left(AuthUserFailure.serverError());
    }
  }

  AuthUserFailure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const AuthUserFailure.networkError();
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode; 
        final data = error.response?.data;
        final apiCode = data is Map<String, dynamic> ? data['code'] : null;
        if (statusCode == 409 || apiCode == 'conflict') {
          return const AuthUserFailure.emailAlreadyInUse();
        }
        if (statusCode == 401 || apiCode == 'unauthorized') {
          return const AuthUserFailure.invalidEmailAndPasswordCombination();
        }
        return const AuthUserFailure.serverError();
      default:
        return const AuthUserFailure.serverError();
    }
  }
}
