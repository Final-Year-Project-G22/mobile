// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/list_sectors_response_body.dart';
import '../models/list_tags_response_body.dart';
import '../models/sector_response.dart';
import '../models/tag_response.dart';

part 'taxonomy_client.g.dart';

@RestApi()
abstract class TaxonomyClient {
  factory TaxonomyClient(Dio dio, {String? baseUrl}) = _TaxonomyClient;

  /// List sectors.
  ///
  /// Lists all available sectors.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Items per page.
  ///
  /// [search] - Search term.
  @GET('/api/v1/taxonomy/sectors')
  Future<HttpResponse<ListSectorsResponseBody>> listTaxonomySectors({
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('search') String? search,
  });

  /// Get sector.
  ///
  /// Retrieves a single sector by ID.
  ///
  /// [id] - Sector ID.
  @GET('/api/v1/taxonomy/sectors/{id}')
  Future<HttpResponse<SectorResponse>> getTaxonomySector({
    @Path('id') required String id,
  });

  /// List tags.
  ///
  /// Lists all available tags.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Items per page.
  ///
  /// [search] - Search term.
  @GET('/api/v1/taxonomy/tags')
  Future<HttpResponse<ListTagsResponseBody>> listTaxonomyTags({
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('search') String? search,
  });

  /// Get tag.
  ///
  /// Retrieves a single tag by ID.
  ///
  /// [id] - Tag ID.
  @GET('/api/v1/taxonomy/tags/{id}')
  Future<HttpResponse<TagResponse>> getTaxonomyTag({
    @Path('id') required String id,
  });
}
