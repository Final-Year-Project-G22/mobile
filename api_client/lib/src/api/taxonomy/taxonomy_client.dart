import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../models/list_sectors_response_body.dart';
import '../models/list_tags_response_body.dart';

part 'taxonomy_client.g.dart';

@RestApi()
abstract class TaxonomyClient {
  factory TaxonomyClient(Dio dio, {String? baseUrl}) = _TaxonomyClient;

  @GET('/api/v1/taxonomy/sectors')
  Future<HttpResponse<ListSectorsResponseBody>> listSectors();

  @GET('/api/v1/taxonomy/tags')
  Future<HttpResponse<ListTagsResponseBody>> listTags();
}
