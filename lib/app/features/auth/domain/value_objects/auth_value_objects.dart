import 'package:dartz/dartz.dart';

import '../../../../../core/value_object.dart';
import '../failures/auth_value_failure.dart';
import '../validator/auth_value_object_validator.dart';

class EmailAddress extends ValueObjects<AuthValueFailure<String>, String> {
  factory EmailAddress(String input) {
    return EmailAddress._(validateEmail(input));
  }

  const EmailAddress._(this.value);
  @override
  final Either<AuthValueFailure<String>, String> value;
}

class Password extends ValueObjects<AuthValueFailure<String>, String> {
  factory Password(String input) {
    return Password._(validatePassword(input));
  }

  const Password._(this.value);
  @override
  final Either<AuthValueFailure<String>, String> value;
}

class FirstName extends ValueObjects<AuthValueFailure<String>, String> {
  factory FirstName(String input) {
    return FirstName._(validateFirstName(input));
  }

  const FirstName._(this.value);
  @override
  final Either<AuthValueFailure<String>, String> value;
}

class LastName extends ValueObjects<AuthValueFailure<String>, String> {
  factory LastName(String input) {
    return LastName._(validateLastName(input));
  }

  const LastName._(this.value);
  @override
  final Either<AuthValueFailure<String>, String> value;
}
