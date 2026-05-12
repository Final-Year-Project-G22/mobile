// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'sector_ref.dart';

part 'business_profile_response.freezed.dart';
part 'business_profile_response.g.dart';

@Freezed()
abstract class BusinessProfileResponse with _$BusinessProfileResponse {
  const factory BusinessProfileResponse({
    /// Company email
    required String companyEmail,

    /// Company name
    required String companyName,

    /// Company phone number
    required String companyPhoneNumber,

    /// Creation timestamp
    required String? createdAt,

    /// Business profile identifier
    required String id,

    /// Social media links
    required Map<String, dynamic> socialLinks,

    /// Associated tags
    required List<dynamic>? tags,

    /// Last update timestamp
    required String? updatedAt,

    /// A URL to the JSON Schema for this object.
    @JsonKey(name: '\$schema') String? schema,

    /// Banner URL
    String? bannerUrl,

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

    /// Business sector
    SectorRef? sector,

    /// Business lifecycle stage
    String? stage,

    /// TIN
    String? taxIdentificationNumber,

    /// Trade license number
    String? tradeLicenseNumber,
  }) = _BusinessProfileResponse;

  factory BusinessProfileResponse.fromJson(Map<String, Object?> json) => _$BusinessProfileResponseFromJson(json);
}
