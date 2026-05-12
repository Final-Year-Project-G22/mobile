import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/failures/auth_value_failure.dart';
import '../domain/validator/auth_value_object_validator.dart';
import 'auth_notifier.dart';

part 'auth_form_notifier.freezed.dart';
part 'auth_form_notifier.g.dart';

@freezed
abstract class LoginFormState with _$LoginFormState {
  const factory LoginFormState({
    @Default('') String identifier,
    @Default('') String password,
    @Default(false) bool isSubmitting,
    @Default(false) bool showErrorMessages,
    AuthValueFailure<String>? identifierFailure,
    AuthValueFailure<String>? passwordFailure,
  }) = _LoginFormState;
}

@riverpod
class LoginFormNotifier extends _$LoginFormNotifier {
  @override
  LoginFormState build() => const LoginFormState();

  void identifierChanged(String value) {
    final result = validateIdentifier(value);
    state = state.copyWith(
      identifier: value,
      identifierFailure: result.fold((l) => l, (r) => null),
    );
  }

  void passwordChanged(String value) {
    final result = validatePassword(value);
    state = state.copyWith(
      password: value,
      passwordFailure: result.fold((l) => l, (r) => null),
    );
  }

  void reset() {
    state = const LoginFormState();
  }

  Future<void> submit() async {
    state = state.copyWith(showErrorMessages: true);

    final identifierResult = validateIdentifier(state.identifier);
    final passwordResult = validatePassword(state.password);

    state = state.copyWith(
      identifierFailure: identifierResult.fold((l) => l, (r) => null),
      passwordFailure: passwordResult.fold((l) => l, (r) => null),
    );

    if (state.identifierFailure != null || state.passwordFailure != null) {
      return;
    }

    state = state.copyWith(isSubmitting: true);

    await ref
        .read(authProvider.notifier)
        .login(identifier: state.identifier, password: state.password);

    state = state.copyWith(isSubmitting: false);
  }
}

// Register Form
//
@freezed
abstract class RegisterFormState with _$RegisterFormState {
  const factory RegisterFormState({
    @Default('') String email,
    @Default('') String password,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String username,
    @Default(false) bool isSubmitting,
    @Default(false) bool showErrorMessages,
    AuthValueFailure<String>? emailFailure,
    AuthValueFailure<String>? passwordFailure,
    AuthValueFailure<String>? firstNameFailure,
    AuthValueFailure<String>? lastNameFailure,
    AuthValueFailure<String>? usernameFailure,
  }) = _RegisterFormState;
}

@riverpod
class RegisterFormNotifier extends _$RegisterFormNotifier {
  @override
  RegisterFormState build() => const RegisterFormState();

  void emailChanged(String value) {
    final result = validateEmail(value);
    state = state.copyWith(
      email: value,
      emailFailure: result.fold((f) => f, (_) => null),
    );
  }

  void passwordChanged(String value) {
    final result = validatePassword(value);
    state = state.copyWith(
      password: value,
      passwordFailure: result.fold((f) => f, (_) => null),
    );
  }

  void firstNameChanged(String value) {
    final result = validateFirstName(value);
    state = state.copyWith(
      firstName: value,
      firstNameFailure: result.fold((f) => f, (_) => null),
    );
  }

  void lastNameChanged(String value) {
    final result = validateLastName(value);
    state = state.copyWith(
      lastName: value,
      lastNameFailure: result.fold((f) => f, (_) => null),
    );
  }

  void usernameChanged(String value) {
    final result = validateUsername(value.isEmpty ? null : value);
    state = state.copyWith(
      username: value,
      usernameFailure: result.fold((f) => f, (_) => null),
    );
  }

  void reset() {
    state = const RegisterFormState();
  }

  Future<void> submit() async {
    state = state.copyWith(showErrorMessages: true);

    final emailResult = validateEmail(state.email);
    final passwordResult = validatePassword(state.password);
    final firstNameResult = validateFirstName(state.firstName);
    final lastNameResult = validateLastName(state.lastName);
    final usernameResult = validateUsername(
      state.username.isEmpty ? null : state.username,
    );

    state = state.copyWith(
      emailFailure: emailResult.fold((f) => f, (_) => null),
      passwordFailure: passwordResult.fold((f) => f, (_) => null),
      firstNameFailure: firstNameResult.fold((f) => f, (_) => null),
      lastNameFailure: lastNameResult.fold((f) => f, (_) => null),
      usernameFailure: usernameResult.fold((f) => f, (_) => null),
    );

    if (state.emailFailure != null ||
        state.passwordFailure != null ||
        state.firstNameFailure != null ||
        state.lastNameFailure != null ||
        state.usernameFailure != null) {
      return;
    }

    state = state.copyWith(isSubmitting: true);

    await ref
        .read(authProvider.notifier)
        .register(
          email: state.email,
          password: state.password,
          firstName: state.firstName,
          lastName: state.lastName,
          username: state.username.isEmpty ? null : state.username,
        );

    state = state.copyWith(isSubmitting: false);
  }
}
