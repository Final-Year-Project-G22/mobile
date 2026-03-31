import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/oauth_pending_email.dart';
import '../domain/entities/oauth_provider.dart';
import '../domain/failures/auth_user_failure.dart';

final authOAuthStateProvider = NotifierProvider<AuthOAuthStateNotifier, AuthOAuthState>(
  AuthOAuthStateNotifier.new,
);

class AuthOAuthStateNotifier extends Notifier<AuthOAuthState> {
  @override
  AuthOAuthState build() => const AuthOAuthState();
}

class AuthOAuthState {
  const AuthOAuthState({
    this.oauthProviders = const [],
    this.isLoadingOAuthProviders = false,
    this.oauthProvidersFailure,
    this.oauthInProgress = false,
    this.pendingOAuthEmail,
  });

  final List<OAuthProvider> oauthProviders;
  final bool isLoadingOAuthProviders;
  final AuthUserFailure? oauthProvidersFailure;
  final bool oauthInProgress;
  final OAuthPendingEmail? pendingOAuthEmail;

  AuthOAuthState copyWith({
    List<OAuthProvider>? oauthProviders,
    bool? isLoadingOAuthProviders,
    Object? oauthProvidersFailure = _noChange,
    bool? oauthInProgress,
    Object? pendingOAuthEmail = _noChange,
  }) {
    return AuthOAuthState(
      oauthProviders: oauthProviders ?? this.oauthProviders,
      isLoadingOAuthProviders: isLoadingOAuthProviders ?? this.isLoadingOAuthProviders,
      oauthProvidersFailure: oauthProvidersFailure == _noChange
          ? this.oauthProvidersFailure
          : oauthProvidersFailure as AuthUserFailure?,
      oauthInProgress: oauthInProgress ?? this.oauthInProgress,
      pendingOAuthEmail: pendingOAuthEmail == _noChange
          ? this.pendingOAuthEmail
          : pendingOAuthEmail as OAuthPendingEmail?,
    );
  }
}

const Object _noChange = Object();
