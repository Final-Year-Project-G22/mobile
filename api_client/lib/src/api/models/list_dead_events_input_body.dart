// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_dead_events_input_body.freezed.dart';
part 'list_dead_events_input_body.g.dart';

@Freezed()
abstract class ListDeadEventsInputBody with _$ListDeadEventsInputBody {
  const factory ListDeadEventsInputBody({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListDeadEventsInputBody;

  factory ListDeadEventsInputBody.fromJson(Map<String, Object?> json) =>
      _$ListDeadEventsInputBodyFromJson(json);
}
