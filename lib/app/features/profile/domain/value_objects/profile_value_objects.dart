import 'package:dartz/dartz.dart';
import 'package:mobile/app/features/profile/domain/failures/profile_value_failure.dart';
import 'package:mobile/app/features/profile/domain/validator/profile_value_object_validator.dart';
import 'package:mobile/core/value_object.dart';

class FirstName extends ValueObjects<ProfileValueFailure<String>, String> {
  @override
  final Either<ProfileValueFailure<String>, String> value;

  const FirstName._(this.value);

  factory FirstName(String input) {
    return FirstName._(validateFirstName(input));
  }
}

class LastName extends ValueObjects<ProfileValueFailure<String>, String> {
  @override
  final Either<ProfileValueFailure<String>, String> value;

  const LastName._(this.value);

  factory LastName(String input) {
    return LastName._(validateLastName(input));
  }
}
