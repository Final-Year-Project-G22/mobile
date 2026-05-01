// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_content_dto.freezed.dart';
part 'user_content_dto.g.dart';

@Freezed()
abstract class UserContentDto with _$UserContentDto {
  const factory UserContentDto({
    /// User email
    required String email,

    /// First name
    required String firstName,

    /// User ID
    required String id,

    /// Last name
    required String lastName,

    /// Thread ID
    String? threadId,

    /// Thread title
    String? threadTitle,
  }) = _UserContentDto;

  factory UserContentDto.fromJson(Map<String, Object?> json) =>
      _$UserContentDtoFromJson(json);
}
