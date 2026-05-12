// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_template_group_output_body.freezed.dart';
part 'delete_template_group_output_body.g.dart';

@Freezed()
abstract class DeleteTemplateGroupOutputBody
    with _$DeleteTemplateGroupOutputBody {
  const factory DeleteTemplateGroupOutputBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _DeleteTemplateGroupOutputBody;

  factory DeleteTemplateGroupOutputBody.fromJson(Map<String, Object?> json) =>
      _$DeleteTemplateGroupOutputBodyFromJson(json);
}
