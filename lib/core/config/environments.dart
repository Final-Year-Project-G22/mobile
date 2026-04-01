enum Environments {
  local,
  development,
  production
  ;

  static Environments fromString(String value) {
    return Environments.values.firstWhere(
      (e) => e.name == value,
      orElse: () => Environments.local,
    );
  }
}
