import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/features/auth/domain/entities/auth_response.dart';
import 'package:mobile/app/features/auth/domain/entities/auth_status.dart';
import 'package:mobile/core/di/auth_providers.dart';

void main() {
  group('currentAccountIdProvider', () {
    test('returns null when auth is Unauthenticated', () async {
      final container = ProviderContainer(
        overrides: [
          resolvedAuthStatusProvider.overrideWithValue(
            const AsyncValue.data(Unauthenticated()),
          ),
        ],
      );
      addTearDown(container.dispose);

      final id = container.read(currentAccountIdProvider);
      expect(id, isNull);
    });

    test('returns account id when auth is Authenticated', () async {
      final user = AuthUser(id: 'u1', firstName: 'T', lastName: 'U');
      final account = AuthAccount(
        id: 'a1',
        email: 't@t.com',
        status: 'active',
      );
      final container = ProviderContainer(
        overrides: [
          resolvedAuthStatusProvider.overrideWithValue(
            AsyncValue.data(Authenticated(user: user, account: account)),
          ),
        ],
      );
      addTearDown(container.dispose);

      final id = container.read(currentAccountIdProvider);
      expect(id, 'a1');
    });

    test('returns null when auth is PendingVerification', () async {
      final container = ProviderContainer(
        overrides: [
          resolvedAuthStatusProvider.overrideWithValue(
            const AsyncValue.data(PendingVerification()),
          ),
        ],
      );
      addTearDown(container.dispose);

      final id = container.read(currentAccountIdProvider);
      expect(id, isNull);
    });
  });
}
