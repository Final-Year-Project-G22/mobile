// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cookie.freezed.dart';
part 'cookie.g.dart';

@Freezed()
abstract class Cookie with _$Cookie {
  const factory Cookie({
    @JsonKey(name: 'Domain') required String domain,
    @JsonKey(name: 'Expires') required DateTime expires,
    @JsonKey(name: 'HttpOnly') required bool httpOnly,
    @JsonKey(name: 'MaxAge') required int maxAge,
    @JsonKey(name: 'Name') required String name,
    @JsonKey(name: 'Partitioned') required bool partitioned,
    @JsonKey(name: 'Path') required String path,
    @JsonKey(name: 'Quoted') required bool quoted,
    @JsonKey(name: 'Raw') required String raw,
    @JsonKey(name: 'RawExpires') required String rawExpires,
    @JsonKey(name: 'SameSite') required int sameSite,
    @JsonKey(name: 'Secure') required bool secure,
    @JsonKey(name: 'Unparsed') required List<dynamic>? unparsed,
    @JsonKey(name: 'Value') required String value,
  }) = _Cookie;

  factory Cookie.fromJson(Map<String, Object?> json) => _$CookieFromJson(json);
}
