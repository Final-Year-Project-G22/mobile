// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_roles_response_body.freezed.dart';
part 'list_roles_response_body.g.dart';

@Freezed()
abstract class ListRolesResponseBody with _$ListRolesResponseBody {
  const factory ListRolesResponseBody({
    /// List of roles
    required List<dynamic>? roles,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListRolesResponseBody;

  factory ListRolesResponseBody.fromJson(Map<String, Object?> json) =>
      _$ListRolesResponseBodyFromJson(json);
}
