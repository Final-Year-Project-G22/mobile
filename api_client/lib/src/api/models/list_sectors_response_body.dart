// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_sectors_response_body.freezed.dart';
part 'list_sectors_response_body.g.dart';

@Freezed()
abstract class ListSectorsResponseBody with _$ListSectorsResponseBody {
  const factory ListSectorsResponseBody({
    /// Sector list
    required List<dynamic>? data,

    /// Current page
    required int page,

    /// Items per page
    required int pageSize,

    /// Total count
    required int total,

    /// Total pages
    required int totalPages,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,
  }) = _ListSectorsResponseBody;

  factory ListSectorsResponseBody.fromJson(Map<String, Object?> json) =>
      _$ListSectorsResponseBodyFromJson(json);
}
