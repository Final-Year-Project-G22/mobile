import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/features/auth/domain/entities/auth_response.dart';
import 'package:mobile/app/features/auth/domain/entities/auth_status.dart';

void main() {
  group('AuthStatus sealed class', () {
    test('Authenticated has non-nullable user and account', () {
      final user = AuthUser(id: 'u1', firstName: 'Test', lastName: 'User');
      final account = AuthAccount(id: 'a1', email: 'test@test.com', status: 'active');
      final auth = Authenticated(user: user, account: account);

      expect(auth.isAuthenticated, isTrue);
      expect(auth.isPendingVerification, isFalse);
      expect(auth.user.id, 'u1');
      expect(auth.account.email, 'test@test.com');
    });

    test('Unauthenticated has no user or account', () {
      const auth = Unauthenticated();

      expect(auth.isAuthenticated, isFalse);
      expect(auth.isPendingVerification, isFalse);
    });

    test('PendingVerification has no user or account', () {
      const auth = PendingVerification();

      expect(auth.isAuthenticated, isFalse);
      expect(auth.isPendingVerification, isTrue);
    });
  });

  group('AuthStatusX.asAuthenticated', () {
    test('returns Authenticated when state is Authenticated', () {
      final user = AuthUser(id: 'u1', firstName: 'T', lastName: 'U');
      final account = AuthAccount(id: 'a1', email: 't@t.com', status: 'active');
      final auth = Authenticated(user: user, account: account);

      final result = auth.asAuthenticated;

      expect(result, isA<Authenticated>());
      expect(result?.user.id, 'u1');
      expect(result?.account.id, 'a1');
    });

    test('returns null when state is Unauthenticated', () {
      const auth = Unauthenticated();
      expect(auth.asAuthenticated, isNull);
    });

    test('returns null when state is PendingVerification', () {
      const auth = PendingVerification();
      expect(auth.asAuthenticated, isNull);
    });
  });
}
