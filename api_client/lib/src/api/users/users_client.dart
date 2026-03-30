// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'dart:convert';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/update_user_profile_request.dart';
import '../models/update_user_profile_response_body.dart';
import '../models/upload_avatar_response.dart';

part 'users_client.g.dart';

@RestApi()
abstract class UsersClient {
  factory UsersClient(Dio dio, {String? baseUrl}) = _UsersClient;

  /// Upload user avatar.
  ///
  /// Uploads and sets the authenticated user's avatar image.
  ///
  /// [file] - Name not received - field will be skipped.
  @MultiPart()
  @POST('/api/v1/users/avatar')
  Future<HttpResponse<UploadAvatarResponse>> uploadAvatar({@Part(name: 'file') required MultipartFile file});

  /// Update user profile.
  ///
  /// Updates the authenticated user's profile information such as name, bio, or other editable account fields.
  ///
  /// [body] - Name not received - field will be skipped.
  @PUT('/api/v1/users/profile')
  Future<HttpResponse<UpdateUserProfileResponseBody>> updateUserProfile({
    @Body() required UpdateUserProfileRequest body,
  });
}
