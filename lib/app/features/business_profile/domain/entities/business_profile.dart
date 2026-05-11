import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_profile.freezed.dart';

@freezed
abstract class BusinessProfile with _$BusinessProfile {
  const factory BusinessProfile({
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
  }) = _BusinessProfile;
}

@freezed
abstract class BusinessProfileSector with _$BusinessProfileSector {
  const factory BusinessProfileSector({
    required String id,
    required String slug,
  }) = _BusinessProfileSector;
}

@freezed
abstract class BusinessProfileTag with _$BusinessProfileTag {
  const factory BusinessProfileTag({
    required String id,
    required String slug,
    required String group,
    required bool isMultiSelect,
  }) = _BusinessProfileTag;
}
