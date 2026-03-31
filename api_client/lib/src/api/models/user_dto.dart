// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@Freezed()
abstract class UserDto with _$UserDto {
  const factory UserDto({
    /// User's first name
    required String firstName,

    /// User's unique identifier
    required String id,

    /// User's last name
    required String lastName,

    /// User's biography
    String? bio,

    /// URL to user's profile image
    String? imageUrl,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, Object?> json) =>
      _$UserDtoFromJson(json);
}
