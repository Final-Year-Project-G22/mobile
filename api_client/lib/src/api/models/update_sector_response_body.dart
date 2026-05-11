// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_sector_response_body.freezed.dart';
part 'update_sector_response_body.g.dart';

@Freezed()
abstract class UpdateSectorResponseBody with _$UpdateSectorResponseBody {
  const factory UpdateSectorResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _UpdateSectorResponseBody;

  factory UpdateSectorResponseBody.fromJson(Map<String, Object?> json) => _$UpdateSectorResponseBodyFromJson(json);
}
