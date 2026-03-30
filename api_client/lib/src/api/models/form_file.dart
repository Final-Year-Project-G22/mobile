// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_file.freezed.dart';
part 'form_file.g.dart';

@Freezed()
abstract class FormFile with _$FormFile {
  const factory FormFile({
    @JsonKey(name: 'ContentType') required String contentType,
    @JsonKey(name: 'Filename') required String filename,
    @JsonKey(name: 'IsSet') required bool isSet,
    @JsonKey(name: 'Size') required int size,
  }) = _FormFile;

  factory FormFile.fromJson(Map<String, Object?> json) => _$FormFileFromJson(json);
}
