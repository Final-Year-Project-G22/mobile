import 'package:dartz/dartz.dart';
import 'entities/auth_response.dart';
import 'failures/auth_user_failure.dart';
import 'value_objects/auth_value_objects.dart';

abstract class IAuthFacade {
  Future<Either<AuthUserFailure, AuthResponse>> registerUser({
    required EmailAddress email,
    required Password password,
    required FirstName firstName,
    required LastName lastName,
  });
  Future<Either<AuthUserFailure, AuthResponse>> login({required EmailAddress email, required Password password});
}
