// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'library_delete_template_output_body.freezed.dart';
part 'library_delete_template_output_body.g.dart';

@Freezed()
abstract class LibraryDeleteTemplateOutputBody
    with _$LibraryDeleteTemplateOutputBody {
  const factory LibraryDeleteTemplateOutputBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _LibraryDeleteTemplateOutputBody;

  factory LibraryDeleteTemplateOutputBody.fromJson(Map<String, Object?> json) =>
      _$LibraryDeleteTemplateOutputBodyFromJson(json);
}
