import 'package:dartz/dartz.dart';
import 'package:mobile/app/features/profile/domain/failures/profile_value_failure.dart';

Either<ProfileValueFailure<String>, String> validateFirstName(String input) {
  if (input.isEmpty) {
    return left(
      ProfileValueFailure.emptyField(
        failedValue: input,
        fieldName: 'First Name',
      ),
    );
  }

  if (input.length < 3) {
    return left(
      ProfileValueFailure.shortName(
        failedValue: input,
        fieldName: 'First Name',
      ),
    );
  }

  if (!RegExp(r'^[a-zA-Z]+$').hasMatch(input)) {
    return left(ProfileValueFailure.invalidFirstName(failedValue: input));
  }

  return right(input);
}

Either<ProfileValueFailure<String>, String> validateLastName(String input) {
  if (input.isEmpty) {
    return left(
      ProfileValueFailure.emptyField(
        failedValue: input,
        fieldName: 'Last Name',
      ),
    );
  }

  if (input.length < 3) {
    return left(
      ProfileValueFailure.shortName(failedValue: input, fieldName: 'Last Name'),
    );
  }

  if (!RegExp(r'^[a-zA-Z]+$').hasMatch(input)) {
    return left(ProfileValueFailure.invalidLastName(failedValue: input));
  }

  return right(input);
}
