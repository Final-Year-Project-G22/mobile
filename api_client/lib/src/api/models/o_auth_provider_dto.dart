// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'o_auth_provider_dto.freezed.dart';
part 'o_auth_provider_dto.g.dart';

@Freezed()
abstract class OAuthProviderDto with _$OAuthProviderDto {
  const factory OAuthProviderDto({
    required String displayName,
    required String icon,
    required String name,
  }) = _OAuthProviderDto;

  factory OAuthProviderDto.fromJson(Map<String, Object?> json) =>
      _$OAuthProviderDtoFromJson(json);
}
