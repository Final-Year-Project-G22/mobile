import 'package:api_client/api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../domain/entities/user_profile.dart';
import '../domain/failures/profile_failure.dart';
import '../domain/i_profile_repository.dart';
import '../domain/value_objects/profile_value_objects.dart';

class ProfileRepositoryImpl implements IProfileRepository {
  const ProfileRepositoryImpl(this._authClient, this._usersClient);
  final AuthenticationClient _authClient;
  final UsersClient _usersClient;

  @override
  Future<Either<ProfileFailure, UserProfile>> getCurrentUser() async {
    try {
      final response = await _authClient.getCurrentUser();
      final user = _toUserProfile(response.data);
      if (user.failureOption.isSome()) {
        return const Left(ProfileFailure.invalidProfileData());
      }
      return Right(user);
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    } on Exception {
      return const Left(ProfileFailure.serverError());
    }
  }

  @override
  Future<Either<ProfileFailure, UserProfile>> updateProfile({
    required String firstName,
    required String lastName,
    String? bio,
  }) async {
    final firstNameVo = FirstName(firstName.trim());
    final lastNameVo = LastName(lastName.trim());
    if (!firstNameVo.isValid() || !lastNameVo.isValid()) {
      return const Left(ProfileFailure.invalidProfileData());
    }

    try {
      final response = await _usersClient.updateUserProfile(
        body: UpdateUserProfileRequest(
          firstName: firstNameVo.getOrCrash(),
          lastName: lastNameVo.getOrCrash(),
          bio: (bio?.trim().isEmpty ?? true) ? null : bio!.trim(),
        ),
      );

      final currentEither = await getCurrentUser();
      return currentEither.fold(
        Left.new,
        (current) => Right(
          current.copyWith(
            firstName: FirstName(response.data.firstName),
            lastName: LastName(response.data.lastName),
            bio: response.data.bio,
          ),
        ),
      );
    } on DioException catch (e) {
      return Left(_mapUpdateError(e));
    } on Exception {
      return const Left(ProfileFailure.unableToUpdate());
    }
  }

  @override
  Future<Either<ProfileFailure, String>> uploadAvatar(XFile file) async {
    try {
      final bytes = await file.readAsBytes();
      final multipartFile = MultipartFile.fromBytes(bytes, filename: file.name);
      final response = await _usersClient.uploadAvatar(file: multipartFile);

      final imageUrl = response.data.imageUrl;
      if (imageUrl.isEmpty) {
        return const Left(ProfileFailure.unableToUpload());
      }
      return Right(imageUrl);
    } on DioException catch (e) {
      return Left(_mapUploadError(e));
    } on Exception {
      return const Left(ProfileFailure.unableToUpload());
    }
  }

  UserProfile _toUserProfile(GetCurrentUserResponseBody data) {
    return UserProfile(
      id: data.user.id,
      firstName: FirstName(data.user.firstName),
      lastName: LastName(data.user.lastName),
      bio: data.user.bio,
      imageUrl: data.user.imageUrl,
    );
  }
}

ProfileFailure _mapDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
      return const ProfileFailure.serverError();
    case DioExceptionType.badResponse:
      final status = error.response?.statusCode;
      if (status == 400) return const ProfileFailure.invalidProfileData();
      return const ProfileFailure.serverError();
    case DioExceptionType.cancel:
    case DioExceptionType.badCertificate:
    case DioExceptionType.unknown:
      return const ProfileFailure.serverError();
  }
}

ProfileFailure _mapUpdateError(DioException error) {
  switch (error.type) {
    case DioExceptionType.badResponse:
      final status = error.response?.statusCode;
      if (status == 400) return const ProfileFailure.invalidProfileData();
      return const ProfileFailure.unableToUpdate();
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
    case DioExceptionType.cancel:
    case DioExceptionType.badCertificate:
    case DioExceptionType.unknown:
      return const ProfileFailure.unableToUpdate();
  }
}

ProfileFailure _mapUploadError(DioException error) {
  switch (error.type) {
    case DioExceptionType.badResponse:
      return const ProfileFailure.unableToUpload();
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
    case DioExceptionType.cancel:
    case DioExceptionType.badCertificate:
    case DioExceptionType.unknown:
      return const ProfileFailure.unableToUpload();
  }
}
