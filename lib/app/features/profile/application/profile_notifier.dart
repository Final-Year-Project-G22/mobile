import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/profile_providers.dart';
import '../domain/failures/profile_failure.dart';
import 'profile_state.dart';

part 'profile_notifier.g.dart';

@riverpod
class ProfileNotifier extends _$ProfileNotifier {
  @override
  ProfileState build() => ProfileState.initial();

  Future<void> loadCurrentUser() async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      successMessage: null,
    );

    final repository = ref.read(profileRepositoryProvider);
    final result = await repository.getCurrentUser();

    state = result.fold(
      (failure) =>
          state.copyWith(isLoading: false, errorMessage: _mapFailure(failure)),
      (user) => state.copyWith(isLoading: false, user: user),
    );
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    String? bio,
  }) async {
    state = state.copyWith(
      isSaving: true,
      errorMessage: null,
      successMessage: null,
    );

    final repository = ref.read(profileRepositoryProvider);
    final result = await repository.updateProfile(
      firstName: firstName,
      lastName: lastName,
      bio: bio,
    );

    state = result.fold(
      (failure) =>
          state.copyWith(isSaving: false, errorMessage: _mapFailure(failure)),
      (user) => state.copyWith(
        isSaving: false,
        user: user,
        successMessage: 'Profile updated successfully',
      ),
    );
  }

  Future<void> uploadAvatarFromGallery() async {
    final picker = ref.read(imagePickerProvider);
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    state = state.copyWith(
      isUploadingAvatar: true,
      errorMessage: null,
      successMessage: null,
    );

    final repository = ref.read(profileRepositoryProvider);
    final result = await repository.uploadAvatar(picked);

    state = result.fold(
      (failure) => state.copyWith(
        isUploadingAvatar: false,
        errorMessage: _mapFailure(failure),
      ),
      (imageUrl) => state.copyWith(
        isUploadingAvatar: false,
        user: state.user?.copyWith(imageUrl: imageUrl),
        successMessage: 'Avatar updated successfully',
      ),
    );
  }

  String _mapFailure(ProfileFailure failure) {
    return failure.when(
      unableToUpdate: () => 'Unable to update profile',
      serverError: () => 'Server error. Please try again.',
      unableToUpload: () => 'Unable to upload avatar',
      invalidProfileData: () => 'Invalid profile data',
    );
  }
}
