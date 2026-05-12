import 'package:api_client/api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../domain/entities/sector.dart';
import '../domain/entities/tag.dart';
import '../domain/failures/taxonomy_failure.dart';
import '../domain/i_taxonomy_repository.dart';

class TaxonomyRepositoryImpl implements ITaxonomyRepository {
  const TaxonomyRepositoryImpl(this._client);

  final TaxonomyClient _client;

  @override
  Future<Either<TaxonomyFailure, List<Sector>>> getSectors({
    int? page,
    int? pageSize,
    String? search,
  }) async {
    try {
      final response = await _client.listTaxonomySectors(
        page: page,
        pageSize: pageSize,
        search: search,
      );

      final sectors = (response.data.data ?? [])
          .cast<SectorResponse>()
          .map(_mapSectorResponseToDomain)
          .toList();

      return Right(sectors);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(TaxonomyFailure.serverError());
    }
  }

  @override
  Future<Either<TaxonomyFailure, List<Tag>>> getTags({
    int? page,
    int? pageSize,
    String? search,
  }) async {
    try {
      final response = await _client.listTaxonomyTags(
        page: page,
        pageSize: pageSize,
        search: search,
      );

      final tags = (response.data.data ?? [])
          .cast<TagResponse>()
          .map(_mapTagResponseToDomain)
          .toList();

      return Right(tags);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } on Exception {
      return const Left(TaxonomyFailure.serverError());
    }
  }

  Sector _mapSectorResponseToDomain(SectorResponse dto) {
    return Sector(
      id: dto.id,
      slug: dto.slug,
      name: dto.nameEn,
      description: dto.descEn,
      parentId: dto.parentId,
    );
  }

  Tag _mapTagResponseToDomain(TagResponse dto) {
    return Tag(
      id: dto.id,
      slug: dto.slug,
      group: dto.group,
      name: dto.nameEn,
      description: dto.descEn,
      isMultiSelect: dto.isMultiSelect,
    );
  }

  TaxonomyFailure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const TaxonomyFailure.networkError();
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 404) {
          return const TaxonomyFailure.notFound();
        } else if (statusCode == 401 || statusCode == 403) {
          return const TaxonomyFailure.unauthorized();
        }
        return const TaxonomyFailure.serverError();
      case DioExceptionType.cancel:
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return const TaxonomyFailure.serverError();
    }
  }
}
