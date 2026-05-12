// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'o_auth_identity_dto.freezed.dart';
part 'o_auth_identity_dto.g.dart';

@Freezed()
abstract class OAuthIdentityDto with _$OAuthIdentityDto {
  const factory OAuthIdentityDto({
    required String provider,
    DateTime? lastUsedAt,
    DateTime? linkedAt,
    String? providerEmail,
  }) = _OAuthIdentityDto;

  factory OAuthIdentityDto.fromJson(Map<String, Object?> json) => _$OAuthIdentityDtoFromJson(json);
}
