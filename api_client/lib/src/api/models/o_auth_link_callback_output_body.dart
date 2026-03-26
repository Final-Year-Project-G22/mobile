// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'o_auth_link_callback_output_body.freezed.dart';
part 'o_auth_link_callback_output_body.g.dart';

@Freezed()
abstract class OAuthLinkCallbackOutputBody with _$OAuthLinkCallbackOutputBody {
  const factory OAuthLinkCallbackOutputBody({
    required String provider,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _OAuthLinkCallbackOutputBody;

  factory OAuthLinkCallbackOutputBody.fromJson(Map<String, Object?> json) =>
      _$OAuthLinkCallbackOutputBodyFromJson(json);
}
