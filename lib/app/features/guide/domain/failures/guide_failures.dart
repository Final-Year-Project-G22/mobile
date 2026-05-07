import 'package:freezed_annotation/freezed_annotation.dart';

part 'guide_failures.freezed.dart';

@freezed
abstract class GuideFailure with _$GuideFailure {
  const factory GuideFailure.serverError({String? message}) = _ServerError;
  const factory GuideFailure.networkError() = _NetworkError;
  const factory GuideFailure.notFound() = _NotFound;
  const factory GuideFailure.unauthorized() = _Unauthorized;
  const factory GuideFailure.conflict({String? message}) = _Conflict;
}
