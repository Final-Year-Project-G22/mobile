import 'package:dartz/dartz.dart';
import 'package:mobile/features/auth/domain/entities/auth_response.dart';
import 'package:mobile/features/auth/domain/failures/auth_user_failure.dart';
import 'package:mobile/features/auth/domain/i_auth_facade.dart';
import 'package:mobile/features/auth/domain/i_auth_repository.dart';
import 'package:mobile/features/auth/domain/value_objects/auth_value_objects.dart';

class AuthFacade implements IAuthFacade {
  final IAuthRepository _repository;

  const AuthFacade(this._repository);

  @override
  Future<Either<AuthUserFailure, AuthResponse>> registerUser({
    required EmailAddress email,
    required Password password,
    required FirstName firstName,
    required LastName lastName,
  }) async {
    final emailValue = email.getOrCrash();
    final passwordValue = password.getOrCrash();
    final firstNameValue = firstName.getOrCrash();
    final lastNameValue = lastName.getOrCrash();
    return _repository.register(
      email: emailValue,
      password: passwordValue,
      firstName: firstNameValue,
      lastName: lastNameValue,
    );
  }
}
