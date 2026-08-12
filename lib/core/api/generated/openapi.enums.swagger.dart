// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum UpdateGuideRequestTranslationMode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('merge')
  merge('merge'),
  @JsonValue('replace')
  replace('replace');

  final String? value;

  const UpdateGuideRequestTranslationMode(this.value);
}

enum UpdateStepRequestTranslationMode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('merge')
  merge('merge'),
  @JsonValue('replace')
  replace('replace');

  final String? value;

  const UpdateStepRequestTranslationMode(this.value);
}

enum ApiV1AdminDashboardUserGrowthGetPeriod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('monthly')
  monthly('monthly'),
  @JsonValue('quarterly')
  quarterly('quarterly'),
  @JsonValue('yearly')
  yearly('yearly');

  final String? value;

  const ApiV1AdminDashboardUserGrowthGetPeriod(this.value);
}

enum ApiV1AdminGuidesStepsIdTranslationsPutTranslationMode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('merge')
  merge('merge'),
  @JsonValue('replace')
  replace('replace');

  final String? value;

  const ApiV1AdminGuidesStepsIdTranslationsPutTranslationMode(this.value);
}

enum ApiV1AdminGuidesIdTranslationsPutTranslationMode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('merge')
  merge('merge'),
  @JsonValue('replace')
  replace('replace');

  final String? value;

  const ApiV1AdminGuidesIdTranslationsPutTranslationMode(this.value);
}
