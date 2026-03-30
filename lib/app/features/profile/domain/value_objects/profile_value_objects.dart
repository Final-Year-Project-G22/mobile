import 'package:dartz/dartz.dart';

import '../../../../../core/value_object.dart';
import '../failures/profile_value_failure.dart';
import '../validator/profile_value_object_validator.dart';

class FirstName extends ValueObjects<ProfileValueFailure<String>, String> {
  factory FirstName(String input) {
    return FirstName._(validateFirstName(input));
  }

  const FirstName._(this.value);
  @override
  final Either<ProfileValueFailure<String>, String> value;
}

class LastName extends ValueObjects<ProfileValueFailure<String>, String> {
  factory LastName(String input) {
    return LastName._(validateLastName(input));
  }

  const LastName._(this.value);
  @override
  final Either<ProfileValueFailure<String>, String> value;
}
