import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/i_ai_repository.dart';
import '../../infrastructure/ai_repository_impl.dart';

part 'ai_providers.g.dart';

@Riverpod(keepAlive: true)
IAiRepository aiRepository(Ref ref) {
  return MockAiRepository();
}
