// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_business_profile_request.freezed.dart';
part 'update_business_profile_request.g.dart';

@Freezed()
abstract class UpdateBusinessProfileRequest with _$UpdateBusinessProfileRequest {
  const factory UpdateBusinessProfileRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Banner URL
    String? bannerUrl,

    /// Company email
    String? companyEmail,

    /// Company name
    String? companyName,

    /// Company phone
    String? companyPhoneNumber,

    /// Business description
    String? description,

    /// Logo URL
    String? logoUrl,

    /// Physical address
    String? physicalAddress,

    /// Business region
    String? region,

    /// Registration date
    DateTime? registrationDate,

    /// Business registration number
    String? registrationNumber,

    /// Sector slug
    String? sectorSlug,

    /// Social media links
    Map<String, dynamic>? socialLinks,

    /// Business lifecycle stage
    String? stage,

    /// Tag slugs
    List<dynamic>? tagSlugs,

    /// TIN
    String? taxIdentificationNumber,

    /// Trade license number
    String? tradeLicenseNumber,
  }) = _UpdateBusinessProfileRequest;

  factory UpdateBusinessProfileRequest.fromJson(Map<String, Object?> json) =>
      _$UpdateBusinessProfileRequestFromJson(json);
}
