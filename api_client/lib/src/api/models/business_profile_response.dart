import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_profile_response.freezed.dart';
part 'business_profile_response.g.dart';

@freezed
abstract class BusinessProfileResponse with _$BusinessProfileResponse {
  const factory BusinessProfileResponse({
    required String id,
    required String companyName,
    required String companyEmail,
    required String companyPhoneNumber,
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
    BusinessProfileSector? sector,
    @Default([]) List<BusinessProfileTag> tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _BusinessProfileResponse;

  factory BusinessProfileResponse.fromJson(Map<String, Object?> json) => _$BusinessProfileResponseFromJson(json);
}

@freezed
abstract class BusinessProfileSector with _$BusinessProfileSector {
  const factory BusinessProfileSector({required String id, required String slug}) = _BusinessProfileSector;

  factory BusinessProfileSector.fromJson(Map<String, Object?> json) => _$BusinessProfileSectorFromJson(json);
}

@freezed
abstract class BusinessProfileTag with _$BusinessProfileTag {
  const factory BusinessProfileTag({
    required String id,
    required String slug,
    required String group,
    required bool isMultiSelect,
  }) = _BusinessProfileTag;

  factory BusinessProfileTag.fromJson(Map<String, Object?> json) => _$BusinessProfileTagFromJson(json);
}
