// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'library_create_template_output_body.freezed.dart';
part 'library_create_template_output_body.g.dart';

@Freezed()
abstract class LibraryCreateTemplateOutputBody
    with _$LibraryCreateTemplateOutputBody {
  const factory LibraryCreateTemplateOutputBody({
    /// Created template ID
    required String id,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _LibraryCreateTemplateOutputBody;

  factory LibraryCreateTemplateOutputBody.fromJson(Map<String, Object?> json) =>
      _$LibraryCreateTemplateOutputBodyFromJson(json);
}
