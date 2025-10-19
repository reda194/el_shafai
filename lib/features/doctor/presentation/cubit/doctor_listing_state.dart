part of 'doctor_listing_cubit.dart';

abstract class DoctorListingState extends Equatable {
  const DoctorListingState();

  @override
  List<Object> get props => [];
}

class DoctorListingInitial extends DoctorListingState {
  const DoctorListingInitial();
}

class DoctorListingLoading extends DoctorListingState {
  const DoctorListingLoading();
}

class DoctorListingLoaded extends DoctorListingState {
  final List<Doctor> doctors;

  const DoctorListingLoaded(this.doctors);

  @override
  List<Object> get props => [doctors];
}

class DoctorListingError extends DoctorListingState {
  final String message;

  const DoctorListingError(this.message);

  @override
  List<Object> get props => [message];
}
