import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../domain/failures/auth_user_failure.dart';
import '../domain/failures/auth_value_failure.dart';
import '../domain/value_objects/auth_value_objects.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    required EmailAddress email,
    required Password password,
    required FirstName firstName,
    required LastName lastName,
    required Option<Either<AuthUserFailure, Unit>> authFailureOrSuccessOption,
    @Default(false) bool isSubmitting,
    @Default(false) bool showErrorMessages,
    AuthValueFailure<String>? fieldFailure,
  }) = _AuthState;

  factory AuthState.initial() => AuthState(
    email: EmailAddress(''),
    password: Password(''),
    firstName: FirstName(''),
    lastName: LastName(''),
    authFailureOrSuccessOption: none(),
  );
}
