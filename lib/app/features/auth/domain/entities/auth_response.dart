class AuthResponse {
  AuthResponse({
    required this.accessToken,
    required this.expiresAt,
    required this.user,
    required this.account,
    this.refreshToken,
  });
  final String accessToken;
  final String? refreshToken;
  final DateTime expiresAt;
  final AuthUser user;
  final AuthAccount account;
}

class AuthUser {
  AuthUser({required this.id, required this.firstName, required this.lastName});
  final String id;
  final String firstName;
  final String lastName;
}

class AuthAccount {
  AuthAccount({
    required this.id,
    required this.email,
    required this.status,
    this.language = 'en',
  });
  final String id;
  final String email;
  final String status;
  final String language;
}
