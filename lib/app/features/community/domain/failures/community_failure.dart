import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_failure.freezed.dart';

@freezed
class CommunityFailure with _$CommunityFailure {
  const factory CommunityFailure.serverError([String? message]) = ServerError;
  const factory CommunityFailure.notFound() = NotFound;
  const factory CommunityFailure.unauthorized() = Unauthorized;
  const factory CommunityFailure.invalidData([String? message]) = InvalidData;
  const factory CommunityFailure.networkError() = NetworkError;
}
