import 'package:mobile/app/features/auth/domain/entities/auth_response.dart';

enum AuthStatusType { authenticated, unauthenticated }

class AuthStatus {
  final AuthStatusType type;
  final AuthUser? user;
  final AuthAccount? account;

  AuthStatus({required this.type, this.user, this.account});

  const AuthStatus.unauthenticated() : type = AuthStatusType.unauthenticated, user = null, account = null;

  const AuthStatus.authenticated({required this.user, required this.account}) : type = AuthStatusType.authenticated;

  bool get isAuthenticated => type == AuthStatusType.authenticated;
}
