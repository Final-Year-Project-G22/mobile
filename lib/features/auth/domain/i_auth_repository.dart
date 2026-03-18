import 'package:dartz/dartz.dart';
import 'package:mobile/features/auth/domain/entities/auth_response.dart';
import 'package:mobile/features/auth/domain/failures/auth_user_failure.dart';

abstract class IAuthRepository {
  Future<Either<AuthUserFailure, AuthResponse>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  });
}
