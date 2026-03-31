import 'auth_response.dart';

enum AuthStatusType { authenticated, unauthenticated, pendingVerification }

class AuthStatus {
  AuthStatus({required this.type, this.user, this.account});

  const AuthStatus.unauthenticated() : type = AuthStatusType.unauthenticated, user = null, account = null;

  const AuthStatus.authenticated({required this.user, required this.account}) : type = AuthStatusType.authenticated;

  const AuthStatus.pendingVerification() : type = AuthStatusType.pendingVerification, user = null, account = null;

  final AuthStatusType type;
  final AuthUser? user;
  final AuthAccount? account;

  bool get isAuthenticated => type == AuthStatusType.authenticated;
  bool get isPendingVerification => type == AuthStatusType.pendingVerification;
}
