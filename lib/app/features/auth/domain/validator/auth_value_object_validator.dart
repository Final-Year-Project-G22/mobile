import 'package:dartz/dartz.dart';
import '../failures/auth_value_failure.dart';

Either<AuthValueFailure<String>, String> validateEmail(String input) {
  if (input.isEmpty) {
    return left(
      AuthValueFailure.emptyField(failedValue: input, fieldName: 'Email'),
    );
  }

  const emailRegex = r'''^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$''';
  if (!RegExp(emailRegex).hasMatch(input)) {
    return left(AuthValueFailure.invalidEmail(failedValue: input));
  }

  return right(input);
}

Either<AuthValueFailure<String>, String> validatePassword(String input) {
  if (input.isEmpty) {
    return left(
      AuthValueFailure.emptyField(failedValue: input, fieldName: 'Password'),
    );
  }

  if (input.length < 8) {
    return left(AuthValueFailure.invalidPassword(failedValue: input));
  }

  return right(input);
}

Either<AuthValueFailure<String>, String> validateFirstName(String input) {
  if (input.isEmpty) {
    return left(
      AuthValueFailure.emptyField(failedValue: input, fieldName: 'First Name'),
    );
  }

  if (input.length < 3) {
    return left(
      AuthValueFailure.shortName(failedValue: input, fieldName: 'First Name'),
    );
  }
  if (!RegExp(r'^[a-zA-Z]+$').hasMatch(input)) {
    return left(AuthValueFailure.invalidFirstName(failedValue: input));
  }

  return right(input);
}

Either<AuthValueFailure<String>, String> validateLastName(String input) {
  if (input.isEmpty) {
    return left(
      AuthValueFailure.emptyField(failedValue: input, fieldName: 'Last Name'),
    );
  }

  if (input.length < 3) {
    return left(
      AuthValueFailure.shortName(failedValue: input, fieldName: 'Last Name'),
    );
  }
  if (!RegExp(r'^[a-zA-Z]+$').hasMatch(input)) {
    return left(AuthValueFailure.invalidLastName(failedValue: input));
  }

  return right(input);
}

Either<AuthValueFailure<String>, String> validateIdentifier(String input) {
  if (input.isEmpty) {
    return left(
      AuthValueFailure.emptyField(
        failedValue: input,
        fieldName: 'Email or Username',
      ),
    );
  }

  if (input.contains('@')) {
    return validateEmail(input);
  }

  if (input.length < 3 || input.length > 32) {
    return left(AuthValueFailure.invalidIdentifier(failedValue: input));
  }
  if (!RegExp(r'^[a-z0-9_]+$').hasMatch(input)) {
    return left(AuthValueFailure.invalidIdentifier(failedValue: input));
  }

  return right(input);
}

Either<AuthValueFailure<String>, String> validateUsername(String? input) {
  if (input == null || input.isEmpty) {
    return right('');
  }

  if (input.length < 3 || input.length > 32) {
    return left(AuthValueFailure.invalidUsername(failedValue: input));
  }
  if (!RegExp(r'^[a-z0-9_]+$').hasMatch(input)) {
    return left(AuthValueFailure.invalidUsername(failedValue: input));
  }

  return right(input);
}

Either<AuthValueFailure<String>, String> validateConfirmPassword(
  String input,
  String password,
) {
  if (input.isEmpty) {
    return left(
      AuthValueFailure.emptyField(
        failedValue: input,
        fieldName: 'Confirm Password',
      ),
    );
  }

  if (input != password) {
    return left(AuthValueFailure.passwordsDontMatch(failedValue: input));
  }

  return right(input);
}
