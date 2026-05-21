// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_calendar_response_body.freezed.dart';
part 'get_calendar_response_body.g.dart';

@Freezed()
abstract class GetCalendarResponseBody with _$GetCalendarResponseBody {
  const factory GetCalendarResponseBody({
    required List<dynamic>? entries,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _GetCalendarResponseBody;

  factory GetCalendarResponseBody.fromJson(Map<String, Object?> json) =>
      _$GetCalendarResponseBodyFromJson(json);
}
