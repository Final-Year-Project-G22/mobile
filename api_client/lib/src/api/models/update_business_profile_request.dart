import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_business_profile_request.freezed.dart';
part 'update_business_profile_request.g.dart';

@freezed
abstract class UpdateBusinessProfileRequest with _$UpdateBusinessProfileRequest {
  const factory UpdateBusinessProfileRequest({
    String? companyName,
    String? companyEmail,
    String? companyPhoneNumber,
    String? physicalAddress,
    String? description,
    String? logoUrl,
    String? bannerUrl,
    Map<String, dynamic>? socialLinks,
    String? registrationNumber,
    DateTime? registrationDate,
    String? taxIdentificationNumber,
    String? tradeLicenseNumber,
    String? region,
    String? stage,
    String? sectorSlug,
    List<String>? tagSlugs,
  }) = _UpdateBusinessProfileRequest;

  factory UpdateBusinessProfileRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateBusinessProfileRequestFromJson(json);
}
