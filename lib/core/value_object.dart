import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'error.dart';

@Immutable()
abstract class ValueObjects<F, T> {
  const ValueObjects();
  Either<F, T> get value;

  T getOrCrash() {
    return value.fold((f) => throw UnexpectedValueError<F>(f), (r) => r);
  }

  bool isValid() => value.isRight();

  Either<F, Unit> get failureOrUnit {
    return value.fold(left, (r) => right(unit));
  }

  @override
  bool operator ==(covariant ValueObjects other) {
    if (identical(this, other)) return true;

    return other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value( $value)';
}
