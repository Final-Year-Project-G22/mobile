// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/create_sector_request.dart';
import '../models/create_sector_response_body.dart';
import '../models/create_tag_request.dart';
import '../models/create_tag_response_body.dart';
import '../models/list_sectors_response_body.dart';
import '../models/list_tags_response_body.dart';
import '../models/sector_response.dart';
import '../models/tag_response.dart';
import '../models/update_sector_request.dart';
import '../models/update_sector_response_body.dart';
import '../models/update_tag_request.dart';
import '../models/update_tag_response_body.dart';

part 'admin_taxonomy_client.g.dart';

@RestApi()
abstract class AdminTaxonomyClient {
  factory AdminTaxonomyClient(Dio dio, {String? baseUrl}) = _AdminTaxonomyClient;

  /// List sectors.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Items per page.
  ///
  /// [search] - Search term.
  @GET('/api/v1/admin/sectors')
  Future<HttpResponse<ListSectorsResponseBody>> listSectors({
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('search') String? search,
  });

  /// Create sector.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/sectors')
  Future<HttpResponse<CreateSectorResponseBody>> createSector({@Body() required CreateSectorRequest body});

  /// Delete sector.
  ///
  /// [id] - Sector ID.
  @DELETE('/api/v1/admin/sectors/{id}')
  Future<HttpResponse<UpdateSectorResponseBody>> deleteSector({@Path('id') required String id});

  /// Get sector.
  ///
  /// [id] - Sector ID.
  @GET('/api/v1/admin/sectors/{id}')
  Future<HttpResponse<SectorResponse>> getSector({@Path('id') required String id});

  /// Update sector.
  ///
  /// [id] - Sector ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PUT('/api/v1/admin/sectors/{id}')
  Future<HttpResponse<UpdateSectorResponseBody>> updateSector({
    @Path('id') required String id,
    @Body() required UpdateSectorRequest body,
  });

  /// List tags.
  ///
  /// [page] - Page number.
  ///
  /// [pageSize] - Items per page.
  ///
  /// [search] - Search term.
  @GET('/api/v1/admin/tags')
  Future<HttpResponse<ListTagsResponseBody>> listTags({
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('search') String? search,
  });

  /// Create tag.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/admin/tags')
  Future<HttpResponse<CreateTagResponseBody>> createTag({@Body() required CreateTagRequest body});

  /// Delete tag.
  ///
  /// [id] - Tag ID.
  @DELETE('/api/v1/admin/tags/{id}')
  Future<HttpResponse<UpdateTagResponseBody>> deleteTag({@Path('id') required String id});

  /// Get tag.
  ///
  /// [id] - Tag ID.
  @GET('/api/v1/admin/tags/{id}')
  Future<HttpResponse<TagResponse>> getTag({@Path('id') required String id});

  /// Update tag.
  ///
  /// [id] - Tag ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @PUT('/api/v1/admin/tags/{id}')
  Future<HttpResponse<UpdateTagResponseBody>> updateTag({
    @Path('id') required String id,
    @Body() required UpdateTagRequest body,
  });
}
