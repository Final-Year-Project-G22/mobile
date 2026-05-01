// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_permissions_response_body.freezed.dart';
part 'list_permissions_response_body.g.dart';

@Freezed()
abstract class ListPermissionsResponseBody with _$ListPermissionsResponseBody {
  const factory ListPermissionsResponseBody({
    /// List of permissions
    required List<dynamic>? permissions,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListPermissionsResponseBody;

  factory ListPermissionsResponseBody.fromJson(Map<String, Object?> json) =>
      _$ListPermissionsResponseBodyFromJson(json);
}
