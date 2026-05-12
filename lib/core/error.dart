class UnexpectedValueError<F> extends Error {
  UnexpectedValueError(this.valueFailure);
  final F valueFailure;
  @override
  String toString() {
    const explanation =
        'Encountered a ValueFailure at an unrecoverable point. Terminating.';
    return Error.safeToString('$explanation Failure was: $valueFailure');
  }
}
