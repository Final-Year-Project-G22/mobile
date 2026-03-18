import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mobile/features/auth/domain/entities/auth_response.dart';
import 'package:mobile/features/auth/domain/failures/auth_user_failure.dart';
import 'package:mobile/features/auth/domain/i_auth_facade.dart';
import 'package:mobile/features/auth/domain/value_objects/auth_value_objects.dart';

import 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final IAuthFacade _authFacade;

  AuthNotifier(this._authFacade) : super(AuthState.initial());

  /// Track Email Changes
  void emailChanged(String input) {
    state = state.copyWith(
      email: EmailAddress(input),
      authFailureOrSuccessOption: none(),
    );
  }

  /// Track Password Changes
  void passwordChanged(String input) {
    state = state.copyWith(
      password: Password(input),
      authFailureOrSuccessOption: none(),
    );
  }

  /// Track First Name Changes
  void firstNameChanged(String input) {
    state = state.copyWith(
      firstName: FirstName(input),
      authFailureOrSuccessOption: none(),
    );
  }

  /// Track Last Name Changes
  void lastNameChanged(String input) {
    state = state.copyWith(
      lastName: LastName(input),
      authFailureOrSuccessOption: none(),
    );
  }

  Future<void> onUserRegister() async {
    Either<AuthUserFailure, AuthResponse>? failureOrSuccess;
    Either<AuthUserFailure, Unit>? failureOrSuccessResult;

    final isEmailValid = state.email.isValid();
    final isPasswordValid = state.password.isValid();
    final isFirstNameValid = state.firstName.isValid();
    final isLastNameValid = state.lastName.isValid();
    if (isEmailValid &&
        isPasswordValid &&
        isFirstNameValid &&
        isLastNameValid) {
      state = state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      );

      failureOrSuccess = await _authFacade.registerUser(
        email: state.email,
        password: state.password,
        firstName: state.firstName,
        lastName: state.lastName,
      );

      failureOrSuccessResult = failureOrSuccess.fold(
        (failure) => left(failure),
        (authResponse) => right(unit),
      );
    }
    state = state.copyWith(
      isSubmitting: false,
      showErrorMessages: true,
      authFailureOrSuccessOption: optionOf(failureOrSuccessResult),
    );
  }
}
