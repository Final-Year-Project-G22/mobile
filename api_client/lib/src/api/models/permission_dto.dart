// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'permission_dto.freezed.dart';
part 'permission_dto.g.dart';

@Freezed()
abstract class PermissionDto with _$PermissionDto {
  const factory PermissionDto({
    /// Permission code
    required String code,

    /// Permission identifier
    required String id,

    /// Permission module
    required String module,

    /// Permission name
    required String name,

    /// Permission description
    String? description,
  }) = _PermissionDto;

  factory PermissionDto.fromJson(Map<String, Object?> json) =>
      _$PermissionDtoFromJson(json);
}
