import 'auth_response.dart';

sealed class AuthStatus {
  const AuthStatus();

  bool get isAuthenticated => this is Authenticated;
  bool get isPendingVerification => this is PendingVerification;
}

class Authenticated extends AuthStatus {
  const Authenticated({required this.user, required this.account});

  final AuthUser user;
  final AuthAccount account;
}

class Unauthenticated extends AuthStatus {
  const Unauthenticated();
}

class PendingVerification extends AuthStatus {
  const PendingVerification();
}

extension AuthStatusX on AuthStatus {
  Authenticated? get asAuthenticated => this is Authenticated ? this as Authenticated : null;
}
