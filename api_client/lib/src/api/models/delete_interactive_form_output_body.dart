// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_interactive_form_output_body.freezed.dart';
part 'delete_interactive_form_output_body.g.dart';

@Freezed()
abstract class DeleteInteractiveFormOutputBody
    with _$DeleteInteractiveFormOutputBody {
  const factory DeleteInteractiveFormOutputBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _DeleteInteractiveFormOutputBody;

  factory DeleteInteractiveFormOutputBody.fromJson(Map<String, Object?> json) =>
      _$DeleteInteractiveFormOutputBodyFromJson(json);
}
