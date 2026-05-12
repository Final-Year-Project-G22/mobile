import 'package:freezed_annotation/freezed_annotation.dart';

part 'taxonomy_failure.freezed.dart';

@freezed
abstract class TaxonomyFailure with _$TaxonomyFailure {
  const factory TaxonomyFailure.serverError([String? message]) = ServerError;
  const factory TaxonomyFailure.networkError() = NetworkError;
  const factory TaxonomyFailure.notFound() = NotFound;
  const factory TaxonomyFailure.unauthorized() = Unauthorized;
}
