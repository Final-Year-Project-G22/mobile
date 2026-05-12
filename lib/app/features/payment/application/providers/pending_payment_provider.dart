import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/di/preferences_provider.dart';

part 'pending_payment_provider.g.dart';

@Riverpod(keepAlive: true)
class PendingPayment extends _$PendingPayment {
  static const _key = 'pending_tx_ref';

  @override
  String? build() {
    final prefs = ref.read(sharedPreferencesProvider);
    return prefs.getString(_key);
  }

  Future<void> set(String txRef) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setString(_key, txRef);
    state = txRef;
  }

  Future<void> clear() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.remove(_key);
    state = null;
  }
}
