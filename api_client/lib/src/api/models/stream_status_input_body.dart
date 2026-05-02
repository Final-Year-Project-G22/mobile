// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'stream_status_input_body.freezed.dart';
part 'stream_status_input_body.g.dart';

@Freezed()
abstract class StreamStatusInputBody with _$StreamStatusInputBody {
  const factory StreamStatusInputBody({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _StreamStatusInputBody;

  factory StreamStatusInputBody.fromJson(Map<String, Object?> json) =>
      _$StreamStatusInputBodyFromJson(json);
}
