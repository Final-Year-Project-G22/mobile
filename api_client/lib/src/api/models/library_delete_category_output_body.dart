// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'library_delete_category_output_body.freezed.dart';
part 'library_delete_category_output_body.g.dart';

@Freezed()
abstract class LibraryDeleteCategoryOutputBody with _$LibraryDeleteCategoryOutputBody {
  const factory LibraryDeleteCategoryOutputBody({
    /// Success message
    required String message,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _LibraryDeleteCategoryOutputBody;

  factory LibraryDeleteCategoryOutputBody.fromJson(Map<String, Object?> json) =>
      _$LibraryDeleteCategoryOutputBodyFromJson(json);
}
