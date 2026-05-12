import 'package:dartz/dartz.dart';

import 'entities/sector.dart';
import 'entities/tag.dart';
import 'failures/taxonomy_failure.dart';

abstract class ITaxonomyRepository {
  Future<Either<TaxonomyFailure, List<Sector>>> getSectors({
    int? page,
    int? pageSize,
    String? search,
  });

  Future<Either<TaxonomyFailure, List<Tag>>> getTags({
    int? page,
    int? pageSize,
    String? search,
  });
}
