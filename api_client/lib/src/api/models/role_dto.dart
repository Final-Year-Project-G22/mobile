// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'role_dto.freezed.dart';
part 'role_dto.g.dart';

@Freezed()
abstract class RoleDto with _$RoleDto {
  const factory RoleDto({
    /// Role code
    required String code,

    /// Role identifier
    required String id,

    /// Mutable role
    required bool isMutable,

    /// System role
    required bool isSystem,

    /// Role name
    required String name,

    /// Role type
    required String type,

    /// Role description
    String? description,
  }) = _RoleDto;

  factory RoleDto.fromJson(Map<String, Object?> json) => _$RoleDtoFromJson(json);
}
