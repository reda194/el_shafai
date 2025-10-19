part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserProfile profile;

  const ProfileLoaded({required this.profile});

  @override
  List<Object> get props => [profile];
}

class ProfileUpdating extends ProfileState {}

class ProfileUpdated extends ProfileState {
  final UserProfile profile;

  const ProfileUpdated({required this.profile});

  @override
  List<Object> get props => [profile];
}

class ProfileImageUploading extends ProfileState {}

class ProfileImageUploaded extends ProfileState {
  final String imageUrl;

  const ProfileImageUploaded({required this.imageUrl});

  @override
  List<Object> get props => [imageUrl];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError({required this.message});

  @override
  List<Object> get props => [message];
}
