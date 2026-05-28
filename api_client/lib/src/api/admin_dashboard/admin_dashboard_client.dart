// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:retrofit/error_logger.dart';

import '../models/activity_logs_response.dart';
import '../models/document_stages_response.dart';
import '../models/document_stats_response.dart';
import '../models/period.dart';
import '../models/report_stats_response.dart';
import '../models/session_stats_response.dart';
import '../models/system_overview_response.dart';
import '../models/user_growth_response.dart';
import '../models/user_stats_response.dart';

part 'admin_dashboard_client.g.dart';

@RestApi()
abstract class AdminDashboardClient {
  factory AdminDashboardClient(Dio dio, {String? baseUrl}) =
      _AdminDashboardClient;

  /// Get recent admin activity logs.
  ///
  /// [limit] - Max entries to return.
  @GET('/api/v1/admin/dashboard/activity-logs')
  Future<HttpResponse<ActivityLogsResponse>> getActivityLogs({
    @Query('limit') int? limit = 10,
  });

  /// Get document pipeline stage breakdown
  @GET('/api/v1/admin/dashboard/document-stages')
  Future<HttpResponse<DocumentStagesResponse>> getDocumentStages();

  /// Get document ingestion statistics
  @GET('/api/v1/admin/dashboard/document-stats')
  Future<HttpResponse<DocumentStatsResponse>> getDocumentStats();

  /// Get content report statistics
  @GET('/api/v1/admin/dashboard/report-stats')
  Future<HttpResponse<ReportStatsResponse>> getReportStats();

  /// Get session statistics
  @GET('/api/v1/admin/dashboard/session-stats')
  Future<HttpResponse<SessionStatsResponse>> getSessionStats();

  /// Get system overview indicators
  @GET('/api/v1/admin/dashboard/system-overview')
  Future<HttpResponse<SystemOverviewResponse>> getSystemOverview();

  /// Get user growth by tier.
  ///
  /// [period] - Grouping period: monthly, quarterly, yearly.
  @GET('/api/v1/admin/dashboard/user-growth')
  Future<HttpResponse<UserGrowthResponse>> getUserGrowth({
    @Query('period') Period? period,
  });

  /// Get user statistics
  @GET('/api/v1/admin/dashboard/user-stats')
  Future<HttpResponse<UserStatsResponse>> getUserStats();
}
