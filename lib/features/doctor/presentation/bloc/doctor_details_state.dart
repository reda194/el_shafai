part of 'doctor_details_bloc.dart';

abstract class DoctorDetailsState extends Equatable {
  const DoctorDetailsState();

  @override
  List<Object> get props => [];
}

class DoctorDetailsInitial extends DoctorDetailsState {
  const DoctorDetailsInitial();
}

class DoctorDetailsLoading extends DoctorDetailsState {
  const DoctorDetailsLoading();
}

class DoctorDetailsLoaded extends DoctorDetailsState {
  final Doctor doctor;
  final bool isFavorite;

  const DoctorDetailsLoaded(this.doctor, {this.isFavorite = false});

  DoctorDetailsLoaded copyWith({
    Doctor? doctor,
    bool? isFavorite,
  }) {
    return DoctorDetailsLoaded(
      doctor ?? this.doctor,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object> get props => [doctor, isFavorite];
}

class DoctorDetailsError extends DoctorDetailsState {
  final String message;

  const DoctorDetailsError(this.message);

  @override
  List<Object> get props => [message];
}

class DoctorNavigation extends DoctorDetailsState {
  final String route;

  const DoctorNavigation(this.route);

  @override
  List<Object> get props => [route];
}

class DoctorShared extends DoctorDetailsState {
  const DoctorShared();
}
