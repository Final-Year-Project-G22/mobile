import 'dart:developer';

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
    @Default('') String email,
    @Default('') String password,
    @Default(false) bool isSubmitting,
    @Default(false) bool showErrorMessages,
    AuthValueFailure<String>? emailFailure,
    AuthValueFailure<String>? passwordFailure,
  }) = _LoginFormState;
}

@riverpod
class LoginFormNotifier extends _$LoginFormNotifier {
  @override
  LoginFormState build() => const LoginFormState();

  void emailChanged(String value) {
    final result = validateEmail(value);
    state = state.copyWith(email: value, emailFailure: result.fold((l) => l, (r) => null));
  }

  void passwordChanged(String value) {
    final result = validatePassword(value);
    state = state.copyWith(password: value, passwordFailure: result.fold((l) => l, (r) => null));
  }

  void reset() {
    state = const LoginFormState();
  }

  Future<void> submit() async {
    state = state.copyWith(showErrorMessages: true);

    // Validate all fields
    final emailResult = validateEmail(state.email);
    final passwordResult = validatePassword(state.password);

    state = state.copyWith(
      emailFailure: emailResult.fold((l) => l, (r) => null),
      passwordFailure: passwordResult.fold((l) => l, (r) => null),
    );

    if (state.emailFailure != null || state.passwordFailure != null) return;

    state = state.copyWith(isSubmitting: true);

    await ref.read(authProvider.notifier).login(email: state.email, password: state.password);

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
    @Default(false) bool isSubmitting,
    @Default(false) bool showErrorMessages,
    AuthValueFailure<String>? emailFailure,
    AuthValueFailure<String>? passwordFailure,
    AuthValueFailure<String>? firstNameFailure,
    AuthValueFailure<String>? lastNameFailure,
  }) = _RegisterFormState;
}

@riverpod
class RegisterFormNotifier extends _$RegisterFormNotifier {
  @override
  RegisterFormState build() => const RegisterFormState();

  void emailChanged(String value) {
    final result = validateEmail(value);
    state = state.copyWith(email: value, emailFailure: result.fold((f) => f, (_) => null));
  }

  void passwordChanged(String value) {
    final result = validatePassword(value);
    state = state.copyWith(password: value, passwordFailure: result.fold((f) => f, (_) => null));
  }

  void firstNameChanged(String value) {
    final result = validateFirstName(value);
    state = state.copyWith(firstName: value, firstNameFailure: result.fold((f) => f, (_) => null));
  }

  void lastNameChanged(String value) {
    final result = validateLastName(value);
    state = state.copyWith(lastName: value, lastNameFailure: result.fold((f) => f, (_) => null));
  }

  void reset() {
    state = const RegisterFormState();
  }

  Future<void> submit() async {
    state = state.copyWith(showErrorMessages: true);

    log('submit called');

    final emailResult = validateEmail(state.email);
    final passwordResult = validatePassword(state.password);
    final firstNameResult = validateFirstName(state.firstName);
    final lastNameResult = validateLastName(state.lastName);

    state = state.copyWith(
      emailFailure: emailResult.fold((f) => f, (_) => null),
      passwordFailure: passwordResult.fold((f) => f, (_) => null),
      firstNameFailure: firstNameResult.fold((f) => f, (_) => null),
      lastNameFailure: lastNameResult.fold((f) => f, (_) => null),
    );

    if (state.emailFailure != null ||
        state.passwordFailure != null ||
        state.firstNameFailure != null ||
        state.lastNameFailure != null) {
      return;
    }

    state = state.copyWith(isSubmitting: true);

    await ref
        .read(authProvider.notifier)
        .register(email: state.email, password: state.password, firstName: state.firstName, lastName: state.lastName);

    state = state.copyWith(isSubmitting: false);
  }
}
