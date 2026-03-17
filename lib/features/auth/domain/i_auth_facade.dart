import 'package:dartz/dartz.dart';
import 'package:mobile/features/auth/domain/entities/auth_response.dart';
import 'package:mobile/features/auth/domain/failures/auth_user_failure.dart';
import 'package:mobile/features/auth/domain/value_objects/auth_value_objects.dart';

abstract class IAuthFacade {
  Future<Either<AuthUserFailure, AuthResponse>> registerUser({
    required EmailAddress email,
    required Password password,
    required FirstName firstName,
    required LastName lastName,
  });
  
  Future<Either<AuthUserFailure, Unit>> logIn({
    required EmailAddress email,
    required Password password,
  });
  
  Future<Either<AuthUserFailure, Unit>> logOut();
}
