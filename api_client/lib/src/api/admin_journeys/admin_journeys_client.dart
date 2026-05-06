// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/invalidate_all_journeys_response_body.dart';
import '../models/invalidate_user_journey_request.dart';
import '../models/invalidate_user_journey_response_body.dart';

part 'admin_journeys_client.g.dart';

@RestApi()
abstract class AdminJourneysClient {
  factory AdminJourneysClient(Dio dio, {String? baseUrl}) = _AdminJourneysClient;

  /// Invalidate all journeys.
  ///
  /// Invalidates all journeys for a guide.
  ///
  /// [guideId] - Guide ID.
  @DELETE('/api/v1/admin/guides/journeys')
  Future<HttpResponse<InvalidateAllJourneysResponseBody>> invalidateAllJourneys({
    @Path('guideId') required String guideId,
  });

  /// Invalidate user journey.
  ///
  /// Invalidates a specific user's journey for a guide.
  ///
  /// [userId] - User ID.
  ///
  /// [body] - Name not received - field will be skipped.
  @DELETE('/api/v1/admin/guides/journeys/users/{userId}')
  Future<HttpResponse<InvalidateUserJourneyResponseBody>> invalidateUserJourney({
    @Path('userId') required String userId,
    @Body() required InvalidateUserJourneyRequest body,
  });
}
