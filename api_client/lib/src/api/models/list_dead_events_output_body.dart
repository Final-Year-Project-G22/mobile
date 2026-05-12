// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_dead_events_output_body.freezed.dart';
part 'list_dead_events_output_body.g.dart';

@Freezed()
abstract class ListDeadEventsOutputBody with _$ListDeadEventsOutputBody {
  const factory ListDeadEventsOutputBody({
    required List<dynamic>? events,
    required int total,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListDeadEventsOutputBody;

  factory ListDeadEventsOutputBody.fromJson(Map<String, Object?> json) => _$ListDeadEventsOutputBodyFromJson(json);
}
