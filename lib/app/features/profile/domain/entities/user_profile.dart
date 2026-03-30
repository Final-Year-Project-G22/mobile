import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile/app/features/profile/domain/failures/profile_value_failure.dart';
import 'package:mobile/app/features/profile/domain/value_objects/profile_value_objects.dart';

part 'user_profile.freezed.dart';

@freezed
abstract class UserProfile with _$UserProfile {
  const UserProfile._();

  const factory UserProfile({
    required String id,
    required FirstName firstName,
    required LastName lastName,
    String? bio,
    String? imageUrl,
  }) = _UserProfile;

  String get fullName =>
      '${firstName.getOrCrash()} ${lastName.getOrCrash()}'.trim();

  Option<ProfileValueFailure<dynamic>> get failureOption {
    final firstNameResult = firstName.failureOrUnit;
    final lastNameResult = lastName.failureOrUnit;

    return firstNameResult
        .andThen(lastNameResult)
        .fold((f) => some(f), (_) => none());
  }
}
