// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'deactivate_device_response_body.freezed.dart';
part 'deactivate_device_response_body.g.dart';

@Freezed()
abstract class DeactivateDeviceResponseBody with _$DeactivateDeviceResponseBody {
  const factory DeactivateDeviceResponseBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _DeactivateDeviceResponseBody;

  factory DeactivateDeviceResponseBody.fromJson(Map<String, Object?> json) =>
      _$DeactivateDeviceResponseBodyFromJson(json);
}
