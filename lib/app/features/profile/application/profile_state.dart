import 'package:freezed_annotation/freezed_annotation.dart';
import '../domain/entities/user_profile.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    UserProfile? user,
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default(false) bool isUploadingAvatar,
    String? errorMessage,
    String? successMessage,
  }) = _ProfileState;

  factory ProfileState.initial() => const ProfileState();
}
