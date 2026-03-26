import 'package:api_client/api_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/app/features/profile/domain/i_profile_repository.dart';
import 'package:mobile/app/features/profile/infrastructure/profile_repository_impl.dart';
import 'package:mobile/core/di/infra_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_providers.g.dart';

@riverpod
ImagePicker imagePicker(Ref ref) {
  return ImagePicker();
}

@riverpod
IProfileRepository profileRepository(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  final dio = apiClient.dio;
  final authClient = AuthenticationClient(dio);
  final usersClient = UsersClient(dio);
  return ProfileRepositoryImpl(authClient, usersClient);
}
