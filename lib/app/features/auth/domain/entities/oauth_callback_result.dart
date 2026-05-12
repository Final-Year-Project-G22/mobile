import 'auth_response.dart';
import 'oauth_pending_email.dart';

class OAuthCallbackResult {
  const OAuthCallbackResult._({
    this.authResponse,
    this.pendingEmail,
  });

  const OAuthCallbackResult.authenticated(AuthResponse response)
    : this._(authResponse: response);

  const OAuthCallbackResult.emailRequired(OAuthPendingEmail email)
    : this._(pendingEmail: email);

  final AuthResponse? authResponse;
  final OAuthPendingEmail? pendingEmail;

  bool get isAuthenticated => authResponse != null;
  bool get isEmailRequired => pendingEmail != null;
}
