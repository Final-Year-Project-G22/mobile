import 'package:api_client/api_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  final client = ApiClient(secureStorage: const FlutterSecureStorage(), baseUrl: 'https://api.example.com');

  client.dio.close();
}
