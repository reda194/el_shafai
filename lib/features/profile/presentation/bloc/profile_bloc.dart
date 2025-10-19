import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/profile/domain/entities/user_profile.dart';
import 'package:neurocare_app/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:neurocare_app/features/profile/domain/usecases/update_user_profile_usecase.dart';
import 'package:neurocare_app/features/profile/domain/usecases/upload_profile_image_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase getUserProfile;
  final UpdateUserProfileUseCase updateUserProfile;
  final UploadProfileImageUseCase uploadProfileImage;

  ProfileBloc({
    required this.getUserProfile,
    required this.updateUserProfile,
    required this.uploadProfileImage,
  }) : super(ProfileInitial()) {
    on<LoadUserProfile>(_onLoadUserProfile);
    on<UpdateUserProfile>(_onUpdateUserProfile);
    on<UploadProfileImage>(_onUploadProfileImage);
  }

  Future<void> _onLoadUserProfile(
    LoadUserProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final result = await getUserProfile(NoParams());
      result.fold(
        (failure) => emit(ProfileError(message: failure.message)),
        (profile) => emit(ProfileLoaded(profile: profile)),
      );
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> _onUpdateUserProfile(
    UpdateUserProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileUpdating());
    try {
      final result = await updateUserProfile(event.profile);
      result.fold(
        (failure) => emit(ProfileError(message: failure.message)),
        (updatedProfile) => emit(ProfileUpdated(profile: updatedProfile)),
      );
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> _onUploadProfileImage(
    UploadProfileImage event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileImageUploading());
    try {
      final result = await uploadProfileImage(event.imagePath);
      result.fold(
        (failure) => emit(ProfileError(message: failure.message)),
        (imageUrl) => emit(ProfileImageUploaded(imageUrl: imageUrl)),
      );
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
