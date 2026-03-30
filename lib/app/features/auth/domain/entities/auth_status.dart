import 'auth_response.dart';

enum AuthStatusType { authenticated, unauthenticated }

class AuthStatus {
  AuthStatus({required this.type, this.user, this.account});

  const AuthStatus.unauthenticated() : type = AuthStatusType.unauthenticated, user = null, account = null;

  const AuthStatus.authenticated({required this.user, required this.account}) : type = AuthStatusType.authenticated;
  final AuthStatusType type;
  final AuthUser? user;
  final AuthAccount? account;

  bool get isAuthenticated => type == AuthStatusType.authenticated;
}
