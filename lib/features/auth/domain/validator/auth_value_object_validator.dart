import 'package:dartz/dartz.dart';
import 'package:mobile/features/auth/domain/failures/auth_value_failure.dart';

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

  if (!RegExp(r'^[a-zA-Z]+$').hasMatch(input) || input.length < 2) {
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

  if (!RegExp(r'^[a-zA-Z]+$').hasMatch(input) || input.length < 2) {
    return left(AuthValueFailure.invalidLastName(failedValue: input));
  }

  return right(input); 
}