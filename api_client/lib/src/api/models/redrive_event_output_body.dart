// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'redrive_event_output_body.freezed.dart';
part 'redrive_event_output_body.g.dart';

@Freezed()
abstract class RedriveEventOutputBody with _$RedriveEventOutputBody {
  const factory RedriveEventOutputBody({
    required bool success,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _RedriveEventOutputBody;

  factory RedriveEventOutputBody.fromJson(Map<String, Object?> json) => _$RedriveEventOutputBodyFromJson(json);
}
