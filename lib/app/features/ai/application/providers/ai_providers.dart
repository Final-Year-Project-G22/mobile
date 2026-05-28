import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/di/app_providers.dart';
import '../../../../../core/di/infra_providers.dart';
import '../../domain/i_ai_repository.dart';
import '../../infrastructure/ai_repository_impl.dart';

part 'ai_providers.g.dart';

@Riverpod(keepAlive: true)
IAiRepository aiRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  final storage = ref.watch(secureStorageProvider);
  return AiRepositoryImpl(
    dio: apiClient.dio,
    httpClient: http.Client(),
    tokenProvider: () => storage.read(key: 'access_token'),
    localeProvider: () async {
      final locale = ref.read(localeProvider);
      return locale?.languageCode;
    },
    baseUrl: apiClient.dio.options.baseUrl,
  );
}
