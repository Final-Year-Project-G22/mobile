// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_business_profile_request.freezed.dart';
part 'create_business_profile_request.g.dart';

@Freezed()
abstract class CreateBusinessProfileRequest
    with _$CreateBusinessProfileRequest {
  const factory CreateBusinessProfileRequest({
    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Banner URL
    String? bannerUrl,

    /// Company email (auto-filled if omitted)
    String? companyEmail,

    /// Company name (auto-filled if omitted)
    String? companyName,

    /// Company phone (auto-filled if omitted)
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

    /// Sector slug (e.g., trade, manufacturing)
    String? sectorSlug,

    /// Social media links
    Map<String, dynamic>? socialLinks,

    /// Business lifecycle stage
    String? stage,

    /// Tag slugs (e.g., sole-proprietor, tax-vat)
    List<dynamic>? tagSlugs,

    /// TIN
    String? taxIdentificationNumber,

    /// Trade license number
    String? tradeLicenseNumber,
  }) = _CreateBusinessProfileRequest;

  factory CreateBusinessProfileRequest.fromJson(Map<String, Object?> json) =>
      _$CreateBusinessProfileRequestFromJson(json);
}
