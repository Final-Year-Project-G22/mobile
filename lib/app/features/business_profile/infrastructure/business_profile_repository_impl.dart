import 'package:api_client/api_client.dart' as api;
import 'package:cross_file/cross_file.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../domain/entities/business_profile.dart';
import '../domain/failures/business_profile_failure.dart';
import '../domain/i_business_profile_repository.dart';

class BusinessProfileRepositoryImpl implements IBusinessProfileRepository {
  const BusinessProfileRepositoryImpl(this._client);

  final api.BusinessProfileClient _client;

  @override
  Future<Either<BusinessProfileFailure, BusinessProfile>>
  getBusinessProfile() async {
    try {
      final response = await _client.getBusinessProfile();
      return Right(_toDomain(response.data));
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    } on Exception {
      return const Left(BusinessProfileFailure.serverError());
    }
  }

  @override
  Future<Either<BusinessProfileFailure, BusinessProfile>>
  createBusinessProfile({
    String? companyName,
    String? companyEmail,
    String? companyPhoneNumber,
    String? physicalAddress,
    String? description,
    String? logoUrl,
    String? bannerUrl,
    String? registrationNumber,
    String? taxIdentificationNumber,
    String? tradeLicenseNumber,
    String? region,
    String? stage,
    String? sectorSlug,
    List<String> tagSlugs = const [],
  }) async {
    try {
      final response = await _client.createBusinessProfile(
        body: api.CreateBusinessProfileRequest(
          companyName: companyName,
          companyEmail: companyEmail,
          companyPhoneNumber: companyPhoneNumber,
          physicalAddress: physicalAddress,
          description: description,
          logoUrl: logoUrl,
          bannerUrl: bannerUrl,
          registrationNumber: registrationNumber,
          taxIdentificationNumber: taxIdentificationNumber,
          tradeLicenseNumber: tradeLicenseNumber,
          region: region,
          stage: stage,
          sectorSlug: sectorSlug,
          tagSlugs: tagSlugs,
        ),
      );
      return Right(_toDomain(response.data));
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    } on Exception {
      return const Left(BusinessProfileFailure.serverError());
    }
  }

  @override
  Future<Either<BusinessProfileFailure, BusinessProfile>>
  updateBusinessProfile({
    String? companyName,
    String? companyEmail,
    String? companyPhoneNumber,
    String? physicalAddress,
    String? description,
    String? logoUrl,
    String? bannerUrl,
    String? registrationNumber,
    String? taxIdentificationNumber,
    String? tradeLicenseNumber,
    String? region,
    String? stage,
    String? sectorSlug,
    List<String>? tagSlugs,
  }) async {
    try {
      final response = await _client.updateBusinessProfile(
        body: api.UpdateBusinessProfileRequest(
          companyName: companyName,
          companyEmail: companyEmail,
          companyPhoneNumber: companyPhoneNumber,
          physicalAddress: physicalAddress,
          description: description,
          logoUrl: logoUrl,
          bannerUrl: bannerUrl,
          registrationNumber: registrationNumber,
          taxIdentificationNumber: taxIdentificationNumber,
          tradeLicenseNumber: tradeLicenseNumber,
          region: region,
          stage: stage,
          sectorSlug: sectorSlug,
          tagSlugs: tagSlugs,
        ),
      );
      return Right(_toDomain(response.data));
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    } on Exception {
      return const Left(BusinessProfileFailure.serverError());
    }
  }

  @override
  Future<Either<BusinessProfileFailure, String>> uploadLogo(
    XFile file,
  ) async {
    return _uploadImage(file, _client.uploadBusinessProfileLogo);
  }

  @override
  Future<Either<BusinessProfileFailure, String>> uploadBanner(
    XFile file,
  ) async {
    return _uploadImage(file, _client.uploadBusinessProfileBanner);
  }

  Future<Either<BusinessProfileFailure, String>> _uploadImage(
    XFile file,
    Future<HttpResponse<api.UploadBusinessImageResponse>> Function({
      required MultipartFile file,
    })
    uploadFn,
  ) async {
    try {
      final bytes = await file.readAsBytes();
      final multipartFile = MultipartFile.fromBytes(bytes, filename: file.name);
      final response = await uploadFn(file: multipartFile);

      final imageUrl = response.data.imageUrl;
      if (imageUrl.isEmpty) {
        return const Left(BusinessProfileFailure.unableToUpload());
      }
      return Right(imageUrl);
    } on DioException catch (e) {
      return Left(_mapUploadError(e));
    } on Exception {
      return const Left(BusinessProfileFailure.unableToUpload());
    }
  }

  BusinessProfile _toDomain(api.BusinessProfileResponse data) {
    return BusinessProfile(
      id: data.id,
      companyName: data.companyName,
      companyEmail: data.companyEmail,
      companyPhoneNumber: data.companyPhoneNumber,
      physicalAddress: data.physicalAddress,
      description: data.description,
      logoUrl: data.logoUrl,
      bannerUrl: data.bannerUrl,
      socialLinks: data.socialLinks,
      registrationNumber: data.registrationNumber,
      registrationDate: data.registrationDate,
      taxIdentificationNumber: data.taxIdentificationNumber,
      tradeLicenseNumber: data.tradeLicenseNumber,
      region: data.region,
      stage: data.stage,
      sector: data.sector == null
          ? null
          : BusinessProfileSector(
              id: data.sector!.id,
              slug: data.sector!.slug,
            ),
      tags: data.tags == null
          ? []
          : data.tags!.map((t) {
              final m = t as Map<String, dynamic>;
              return BusinessProfileTag(
                id: m['id'] as String,
                slug: m['slug'] as String,
                group: m['group'] as String,
                isMultiSelect: m['isMultiSelect'] as bool? ?? true,
              );
            }).toList(),
    );
  }

  BusinessProfileFailure _mapDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return const BusinessProfileFailure.serverError();
      case DioExceptionType.badResponse:
        final status = error.response?.statusCode;
        if (status == 404) return const BusinessProfileFailure.notFound();
        if (status == 409) return const BusinessProfileFailure.alreadyExists();
        if (status == 400 || status == 422) {
          return const BusinessProfileFailure.invalidData();
        }
        return const BusinessProfileFailure.serverError();
    }
  }

  BusinessProfileFailure _mapUploadError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return const BusinessProfileFailure.serverError();
      case DioExceptionType.badResponse:
        final status = error.response?.statusCode;
        if (status == 413) return const BusinessProfileFailure.unableToUpload();
        if (status == 415) return const BusinessProfileFailure.unableToUpload();
        return const BusinessProfileFailure.serverError();
    }
  }
}
