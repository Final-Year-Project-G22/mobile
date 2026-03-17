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
    print("AuthFaced enterd");
    final emailValue = email.value.getOrElse(
      () => throw Exception('Invalid email'),
    );
    final passwordValue = password.value.getOrElse(
      () => throw Exception('Invalid password'),
    );
    final firstNameValue = firstName.value.getOrElse(
      () => throw Exception('Invalid first name'),
    );
    final lastNameValue = lastName.value.getOrElse(
      () => throw Exception('Invalid last name'),
    );

    return _repository.register(
      email: emailValue,
      password: passwordValue,
      firstName: firstNameValue,
      lastName: lastNameValue,
    );
  }

  @override
  Future<Either<AuthUserFailure, Unit>> logIn({
    required EmailAddress email,
    required Password password,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthUserFailure, Unit>> logOut() async {
    throw UnimplementedError();
  }
}
