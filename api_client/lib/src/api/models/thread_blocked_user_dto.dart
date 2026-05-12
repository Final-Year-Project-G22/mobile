// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'thread_blocked_user_dto.freezed.dart';
part 'thread_blocked_user_dto.g.dart';

@Freezed()
abstract class ThreadBlockedUserDto with _$ThreadBlockedUserDto {
  const factory ThreadBlockedUserDto({
    /// Blocked by account ID
    required String blockedBy,

    /// Blocked user account ID
    required String blockedUserId,

    /// Created timestamp
    required String createdAt,

    /// Thread ID
    required String threadId,

    /// Blocked by first name
    String? blockedByFirstName,

    /// Blocked by last name
    String? blockedByLastName,

    /// Blocked user email
    String? blockedUserEmail,

    /// Blocked user first name
    String? blockedUserFirstName,

    /// Blocked user last name
    String? blockedUserLastName,

    /// Reason for blocking
    String? reason,

    /// Thread slug
    String? threadSlug,

    /// Thread title
    String? threadTitle,
  }) = _ThreadBlockedUserDto;

  factory ThreadBlockedUserDto.fromJson(Map<String, Object?> json) =>
      _$ThreadBlockedUserDtoFromJson(json);
}
