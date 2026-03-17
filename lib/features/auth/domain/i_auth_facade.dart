import 'package:dartz/dartz.dart';
import 'package:mobile/features/auth/domain/failures/auth_failure.dart';
import 'package:mobile/features/auth/domain/value_objects/auth_value_objects.dart';

abstract class IAuthFacade {
  Future<Either<AuthFailure, Unit>> registerUser({
    required EmailAddress email,
    required Password password,
    required FirstName firstName,
    required LastName lastName,
  });
  
  Future<Either<AuthFailure, Unit>> logIn({
    required EmailAddress email,
    required Password password,
  });
  
  Future<Either<AuthFailure, Unit>> logOut();
}
