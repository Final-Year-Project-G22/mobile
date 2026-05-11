// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_account_dto.freezed.dart';
part 'admin_account_dto.g.dart';

@Freezed()
abstract class AdminAccountDto with _$AdminAccountDto {
  const factory AdminAccountDto({
    /// Creation timestamp
    required String createdAt,

    /// Account email
    required String email,

    /// User first name
    required String firstName,

    /// Account identifier
    required String id,

    /// User last name
    required String lastName,

    /// Assigned roles
    required List<dynamic>? roles,

    /// Account status
    required String status,

    /// Last login timestamp
    String? lastLoginAt,

    /// Account username
    String? username,
  }) = _AdminAccountDto;

  factory AdminAccountDto.fromJson(Map<String, Object?> json) => _$AdminAccountDtoFromJson(json);
}
