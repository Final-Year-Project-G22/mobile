// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_interactive_form_request.freezed.dart';
part 'update_interactive_form_request.g.dart';

@Freezed()
abstract class UpdateInteractiveFormRequest
    with _$UpdateInteractiveFormRequest {
  const factory UpdateInteractiveFormRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Form description
    String? description,

    /// Form layout JSON
    Map<String, dynamic>? formLayout,

    /// Form name
    String? name,
  }) = _UpdateInteractiveFormRequest;

  factory UpdateInteractiveFormRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateInteractiveFormRequestFromJson(json);
}
