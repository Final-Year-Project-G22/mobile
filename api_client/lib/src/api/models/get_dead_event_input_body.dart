// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_dead_event_input_body.freezed.dart';
part 'get_dead_event_input_body.g.dart';

@Freezed()
abstract class GetDeadEventInputBody with _$GetDeadEventInputBody {
  const factory GetDeadEventInputBody({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _GetDeadEventInputBody;

  factory GetDeadEventInputBody.fromJson(Map<String, Object?> json) => _$GetDeadEventInputBodyFromJson(json);
}
