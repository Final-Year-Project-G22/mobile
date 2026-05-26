// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/create_compliance_entry_request.dart';
import '../models/create_compliance_entry_response_body.dart';
import '../models/delete_compliance_entry_response_body.dart';
import '../models/get_calendar_response_body.dart';
import '../models/list_compliance_entries_response_body.dart';
import '../models/list_compliance_types_response_body.dart';
import '../models/update_compliance_entry_request.dart';
import '../models/update_compliance_entry_response_body.dart';

part 'compliance_client.g.dart';

@RestApi()
abstract class ComplianceClient {
  factory ComplianceClient(Dio dio, {String? baseUrl}) = _ComplianceClient;

  /// Get compliance calendar.
  ///
  /// Returns upcoming compliance deadlines and scheduled alerts for the authenticated user.
  @GET('/api/v1/compliance/calendar')
  Future<HttpResponse<GetCalendarResponseBody>> getComplianceCalendar();

  /// List compliance entries.
  ///
  /// Lists all compliance entries for a business profile.
  @GET('/api/v1/compliance/entries')
  Future<HttpResponse<ListComplianceEntriesResponseBody>>
  listComplianceEntries({
    @Query('businessProfileId') String? businessProfileId,
  });

  /// Create compliance entry.
  ///
  /// Creates a new compliance entry for a business profile.
  ///
  /// [body] - Name not received - field will be skipped.
  @POST('/api/v1/compliance/entries')
  Future<HttpResponse<CreateComplianceEntryResponseBody>>
  createComplianceEntry({
    @Body() required CreateComplianceEntryRequest body,
  });

  /// Delete compliance entry.
  ///
  /// Deletes a compliance entry.
  @DELETE('/api/v1/compliance/entries/{id}')
  Future<HttpResponse<DeleteComplianceEntryResponseBody>>
  deleteComplianceEntry({
    @Path('id') required String id,
  });

  /// Update compliance entry.
  ///
  /// Updates a compliance entry.
  ///
  /// [body] - Name not received - field will be skipped.
  @PATCH('/api/v1/compliance/entries/{id}')
  Future<HttpResponse<UpdateComplianceEntryResponseBody>>
  updateComplianceEntry({
    @Path('id') required String id,
    @Body() required UpdateComplianceEntryRequest body,
  });

  /// List compliance types.
  ///
  /// Lists all seeded compliance types for dropdown selections.
  @GET('/api/v1/compliance/types')
  Future<HttpResponse<ListComplianceTypesResponseBody>> listComplianceTypes();
}
