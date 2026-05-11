// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_dto.freezed.dart';
part 'account_dto.g.dart';

@Freezed()
abstract class AccountDto with _$AccountDto {
  const factory AccountDto({
    /// Account email address
    required String email,

    /// Account's unique identifier
    required String id,

    /// Account status (pending_verification, active, locked, suspended, disabled)
    required String status,

    /// Account username
    String? username,
  }) = _AccountDto;

  factory AccountDto.fromJson(Map<String, Object?> json) => _$AccountDtoFromJson(json);
}
