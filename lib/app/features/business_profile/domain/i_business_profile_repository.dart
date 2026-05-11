import 'package:dartz/dartz.dart';

import 'entities/business_profile.dart';
import 'failures/business_profile_failure.dart';

abstract class IBusinessProfileRepository {
  Future<Either<BusinessProfileFailure, BusinessProfile>> getBusinessProfile();

  Future<Either<BusinessProfileFailure, BusinessProfile>> createBusinessProfile({
    String? companyName,
    String? companyEmail,
    String? companyPhoneNumber,
    String? physicalAddress,
    String? description,
    String? region,
    String? stage,
    String? sectorSlug,
    List<String> tagSlugs,
  });

  Future<Either<BusinessProfileFailure, BusinessProfile>> updateBusinessProfile({
    String? companyName,
    String? companyEmail,
    String? companyPhoneNumber,
    String? physicalAddress,
    String? description,
    String? region,
    String? stage,
    String? sectorSlug,
    List<String>? tagSlugs,
  });
}
