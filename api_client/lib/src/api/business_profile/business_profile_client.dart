// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/business_profile_response.dart';
import '../models/create_business_profile_request.dart';
import '../models/update_business_profile_request.dart';

part 'business_profile_client.g.dart';

@RestApi()
abstract class BusinessProfileClient {
  factory BusinessProfileClient(Dio dio, {String? baseUrl}) =
      _BusinessProfileClient;

  /// Get business profile.
  ///
  /// Retrieves the authenticated user's business profile.
  @GET('/api/v1/users/business-profile')
  Future<HttpResponse<BusinessProfileResponse>> getBusinessProfile();

  /// Create business profile.
  ///
  /// Creates a business profile for the authenticated user. Accepts slugs for sector and tags, which are resolved server-side. Auto-fills company name, email, and phone from account data if omitted.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/users/business-profile')
  Future<HttpResponse<BusinessProfileResponse>> createBusinessProfile({
    @Body() required CreateBusinessProfileRequest body,
  });

  /// Update business profile.
  ///
  /// Updates the authenticated user's business profile. Accepts slugs for sector and tags, which are resolved server-side.
  ///
  /// [body] - Name not received - field will be skipped.
  @PUT('/api/v1/users/business-profile')
  Future<HttpResponse<BusinessProfileResponse>> updateBusinessProfile({
    @Body() required UpdateBusinessProfileRequest body,
  });
}
