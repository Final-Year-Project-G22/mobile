import 'package:dartz/dartz.dart';
import 'package:mobile/core/value_object.dart';
import 'package:mobile/features/auth/domain/failures/auth_value_failure.dart';
import 'package:mobile/features/auth/domain/validator/auth_value_object_validator.dart';

class EmailAddress extends ValueObjects<AuthValueFailure<String>, String> {
  @override
  final Either<AuthValueFailure<String>, String> value;

  const EmailAddress._(this.value);

  factory EmailAddress(String input) {
    return EmailAddress._(validateEmail(input));
  }
}

class Password extends ValueObjects<AuthValueFailure<String>, String> {
  @override
  final Either<AuthValueFailure<String>, String> value;

  const Password._(this.value);

  factory Password(String input) {
    return Password._(validatePassword(input));
  }
}

class FirstName extends ValueObjects<AuthValueFailure<String>, String> {
  @override
  final Either<AuthValueFailure<String>, String> value;
  
  const FirstName._(this.value);

  factory FirstName(String input) {
    return FirstName._(validateFirstName(input));
  }
}

class LastName extends ValueObjects<AuthValueFailure<String>, String> {
  @override
  final Either<AuthValueFailure<String>, String> value;

  const LastName._(this.value);

  factory LastName(String input) {
    return LastName._(validateLastName(input));
  }
}
