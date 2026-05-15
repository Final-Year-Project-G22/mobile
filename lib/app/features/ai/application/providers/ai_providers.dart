import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/di/infra_providers.dart';
import '../../domain/i_ai_repository.dart';
import '../../infrastructure/ai_repository_impl.dart';

part 'ai_providers.g.dart';

@Riverpod(keepAlive: true)
IAiRepository aiRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AiRepositoryImpl(dio: apiClient.dio);
}
