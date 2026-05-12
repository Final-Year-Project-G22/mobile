import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_value_failure.freezed.dart';

@freezed
abstract class AuthValueFailure<T> with _$AuthValueFailure<T> {
  const factory AuthValueFailure.emptyField({
    required T failedValue,
    required String fieldName,
  }) = EmptyField<T>;

  const factory AuthValueFailure.invalidEmail({required T failedValue}) =
      InvalidEmail<T>;

  const factory AuthValueFailure.invalidPassword({required T failedValue}) =
      InvalidPassword<T>;

  const factory AuthValueFailure.invalidFirstName({required T failedValue}) =
      InvalidFirstName<T>;

  const factory AuthValueFailure.invalidLastName({required T failedValue}) =
      InvalidLastName<T>;

  const factory AuthValueFailure.shortName({
    required T failedValue,
    required String fieldName,
  }) = ShortName<T>;

  const factory AuthValueFailure.invalidIdentifier({required T failedValue}) =
      InvalidIdentifier<T>;

  const factory AuthValueFailure.invalidUsername({required T failedValue}) =
      InvalidUsername<T>;
}

extension AuthValueFailureX on AuthValueFailure {
  String toMessage() => maybeWhen(
    emptyField: (_, fieldName) => '$fieldName is required',
    shortName: (_, fieldName) => '$fieldName must be at least 3 characters',
    invalidEmail: (_) => 'Invalid email address',
    invalidPassword: (_) => 'Password must be at least 8 characters',
    invalidFirstName: (_) => 'First name is invalid',
    invalidLastName: (_) => 'Last name is invalid',
    invalidIdentifier: (_) =>
        'Must be 3-32 chars: lowercase letters, digits, or underscore',
    invalidUsername: (_) =>
        'Username must be 3-32 chars: lowercase letters, digits, or underscore',
    orElse: () => 'Invalid input',
  );
}
