import 'package:api_client/api_client.dart';

void main() {
  final client = ApiClient(baseUrl: 'https://api.example.com');

  client.dio.close();
}
