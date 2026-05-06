// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_interactive_form_request.freezed.dart';
part 'create_interactive_form_request.g.dart';

@Freezed()
abstract class CreateInteractiveFormRequest with _$CreateInteractiveFormRequest {
  const factory CreateInteractiveFormRequest({
    /// Form layout JSON
    required Map<String, dynamic> formLayout,

    /// Form name
    required String name,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Form description
    String? description,
  }) = _CreateInteractiveFormRequest;

  factory CreateInteractiveFormRequest.fromJson(Map<String, Object?> json) =>
      _$CreateInteractiveFormRequestFromJson(json);
}
