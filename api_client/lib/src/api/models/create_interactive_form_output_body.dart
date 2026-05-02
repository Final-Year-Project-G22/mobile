// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_interactive_form_output_body.freezed.dart';
part 'create_interactive_form_output_body.g.dart';

@Freezed()
abstract class CreateInteractiveFormOutputBody
    with _$CreateInteractiveFormOutputBody {
  const factory CreateInteractiveFormOutputBody({
    /// Created form ID
    required String id,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _CreateInteractiveFormOutputBody;

  factory CreateInteractiveFormOutputBody.fromJson(Map<String, Object?> json) =>
      _$CreateInteractiveFormOutputBodyFromJson(json);
}
