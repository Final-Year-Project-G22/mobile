import 'package:api_client/api_client.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AppNetworkInfo implements NetworkInfo {
  AppNetworkInfo({Connectivity? connectivity}) : _connectivity = connectivity ?? Connectivity();
  final Connectivity _connectivity;

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }

  @override
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.map(
      (results) => !results.contains(ConnectivityResult.none),
    );
  }

  Future<void> ensureConnected() async {
    if (!await isConnected) {
      throw const NetworkException(message: 'No internet connection');
    }
  }
}
