// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ask_request.freezed.dart';
part 'ask_request.g.dart';

@Freezed()
abstract class AskRequest with _$AskRequest {
  const factory AskRequest({
    /// User question
    required String query,

    /// Number of context chunks to retrieve
    @Default(5) int topK,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Language code (e.g. en, am)
    String? language,

    /// Optional conversation ID to continue
    String? sessionId,

    /// Custom conversation title
    String? title,
  }) = _AskRequest;

  factory AskRequest.fromJson(Map<String, Object?> json) => _$AskRequestFromJson(json);
}
