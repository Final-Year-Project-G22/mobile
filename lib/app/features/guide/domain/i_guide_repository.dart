import 'package:dartz/dartz.dart';

import 'entities/completion_stats.dart';
import 'entities/guide_card.dart';
import 'entities/guide_detail.dart';
import 'entities/guide_with_progress.dart';
import 'entities/step_bookmark.dart';
import 'failures/guide_failures.dart';

abstract class IGuideRepository {
  Future<Either<GuideFailure, List<GuideCard>>> listGuides({
    List<String>? sectorIds,
    List<String>? tagIds,
  });

  Future<Either<GuideFailure, List<GuideCard>>> listAllGuides();

  Future<Either<GuideFailure, List<GuideCard>>> searchGuides(
    String query,
  );
  Future<Either<GuideFailure, List<GuideCard>>> getRecentlyViewed();
  Future<Either<GuideFailure, GuideDetail>> getPersonalizedGuide(
    String guideSlug,
  );
  Future<Either<GuideFailure, List<GuideWithProgress>>> getInProgressGuides();
  Future<Either<GuideFailure, CompletionStats>> getCompletionStats();
  Future<Either<GuideFailure, Unit>> startStep(String stepId);
  Future<Either<GuideFailure, Unit>> completeStep(String stepId);
  Future<Either<GuideFailure, Unit>> skipStep(String stepId);
  Future<Either<GuideFailure, Unit>> markStepIncomplete(String stepId);
  Future<Either<GuideFailure, Unit>> addBookmark(String stepId);
  Future<Either<GuideFailure, Unit>> removeBookmark(String stepId);
  Future<Either<GuideFailure, List<StepBookmark>>> listBookmarks();
}
