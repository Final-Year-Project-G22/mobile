// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_sector_response_body.freezed.dart';
part 'create_sector_response_body.g.dart';

@Freezed()
abstract class CreateSectorResponseBody with _$CreateSectorResponseBody {
  const factory CreateSectorResponseBody({
    /// Created sector ID
    required String id,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _CreateSectorResponseBody;

  factory CreateSectorResponseBody.fromJson(Map<String, Object?> json) =>
      _$CreateSectorResponseBodyFromJson(json);
}
