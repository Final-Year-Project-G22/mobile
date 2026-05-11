import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../models/business_profile_response.dart';
import '../models/create_business_profile_request.dart';
import '../models/update_business_profile_request.dart';

part 'business_profile_client.g.dart';

@RestApi()
abstract class BusinessProfileClient {
  factory BusinessProfileClient(Dio dio, {String? baseUrl}) = _BusinessProfileClient;

  @GET('/api/v1/users/business-profile')
  Future<HttpResponse<BusinessProfileResponse>> getBusinessProfile();

  @POST('/api/v1/users/business-profile')
  Future<HttpResponse<BusinessProfileResponse>> createBusinessProfile({
    @Body() required CreateBusinessProfileRequest body,
  });

  @PUT('/api/v1/users/business-profile')
  Future<HttpResponse<BusinessProfileResponse>> updateBusinessProfile({
    @Body() required UpdateBusinessProfileRequest body,
  });
}
