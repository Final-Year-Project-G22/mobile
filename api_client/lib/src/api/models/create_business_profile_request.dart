import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_business_profile_request.freezed.dart';
part 'create_business_profile_request.g.dart';

@freezed
abstract class CreateBusinessProfileRequest with _$CreateBusinessProfileRequest {
  const factory CreateBusinessProfileRequest({
    String? companyName,
    String? companyEmail,
    String? companyPhoneNumber,
    String? physicalAddress,
    String? description,
    String? logoUrl,
    String? bannerUrl,
    @Default({}) Map<String, dynamic> socialLinks,
    String? registrationNumber,
    DateTime? registrationDate,
    String? taxIdentificationNumber,
    String? tradeLicenseNumber,
    String? region,
    String? stage,
    String? sectorSlug,
    @Default([]) List<String> tagSlugs,
  }) = _CreateBusinessProfileRequest;

  factory CreateBusinessProfileRequest.fromJson(Map<String, Object?> json) =>
      _$CreateBusinessProfileRequestFromJson(json);
}
