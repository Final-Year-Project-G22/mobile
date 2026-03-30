import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'entities/user_profile.dart';
import 'failures/profile_failure.dart';

abstract class IProfileRepository {
  Future<Either<ProfileFailure, UserProfile>> getCurrentUser();

  Future<Either<ProfileFailure, UserProfile>> updateProfile({
    required String firstName,
    required String lastName,
    String? bio,
  });

  Future<Either<ProfileFailure, String>> uploadAvatar(XFile file);
}
