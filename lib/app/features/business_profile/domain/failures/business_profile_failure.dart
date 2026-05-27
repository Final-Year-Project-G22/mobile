import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_profile_failure.freezed.dart';

@freezed
abstract class BusinessProfileFailure with _$BusinessProfileFailure {
  const factory BusinessProfileFailure.serverError() = _ServerError;
  const factory BusinessProfileFailure.notFound() = _NotFound;
  const factory BusinessProfileFailure.alreadyExists() = _AlreadyExists;
  const factory BusinessProfileFailure.invalidData() = _InvalidData;
  const factory BusinessProfileFailure.unableToUpload() = _UnableToUpload;
}
