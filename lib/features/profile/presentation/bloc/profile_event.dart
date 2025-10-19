part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadUserProfile extends ProfileEvent {}

class UpdateUserProfile extends ProfileEvent {
  final UserProfile profile;

  const UpdateUserProfile(this.profile);

  @override
  List<Object> get props => [profile];
}

class UploadProfileImage extends ProfileEvent {
  final String imagePath;

  const UploadProfileImage(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}
