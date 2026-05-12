import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'pending_payment_provider.g.dart';

@Riverpod(keepAlive: true)
class PendingPayment extends _$PendingPayment {
  static const _key = 'pending_tx_ref';

  @override
  String? build() => null;

  Future<void> set(String txRef) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, txRef);
    } on Exception catch (e) {
      debugPrint('[PAYMENT] Failed to persist txRef: $e');
    }
    state = txRef;
  }

  Future<void> clear() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
    } on Exception catch (e) {
      debugPrint('[PAYMENT] Failed to clear txRef: $e');
    }
    state = null;
  }
}
