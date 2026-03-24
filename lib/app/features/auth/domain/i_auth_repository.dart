import 'package:dartz/dartz.dart';
import 'package:mobile/app/features/auth/domain/entities/auth_response.dart';
import 'package:mobile/app/features/auth/domain/failures/auth_user_failure.dart';

abstract class IAuthRepository {
  Future<Either<AuthUserFailure, AuthResponse>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
  Future<Either<AuthUserFailure, AuthResponse>> login({required String email, required String password});
  Future<Either<AuthUserFailure, Unit>> logout();
  Future<Either<AuthUserFailure, Unit>> logoutAll();
}
