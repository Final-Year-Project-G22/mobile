class AuthResponse {
  final String accessToken;
  final String? refreshToken;
  final DateTime expiresAt;
  final AuthUser user;
  final AuthAccount account;

  AuthResponse({
    required this.accessToken,
    this.refreshToken,
    required this.expiresAt,
    required this.user,
    required this.account,
  });
}

class AuthUser {
  final String id;
  final String firstName;
  final String lastName;

  AuthUser({required this.id, required this.firstName, required this.lastName});
}

class AuthAccount {
  final String id;
  final String email;
  final String status;

  AuthAccount({required this.id, required this.email, required this.status});
}
