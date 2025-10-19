import 'package:equatable/equatable.dart';
import 'package:neurocare_app/features/doctor/domain/entities/doctor.dart';

abstract class DoctorSearchState extends Equatable {
  const DoctorSearchState();

  @override
  List<Object> get props => [];
}

class DoctorSearchInitial extends DoctorSearchState {
  const DoctorSearchInitial();
}

class DoctorSearchLoading extends DoctorSearchState {
  const DoctorSearchLoading();
}

class DoctorSearchSuccess extends DoctorSearchState {
  final List<Doctor> doctors;

  const DoctorSearchSuccess(this.doctors);

  @override
  List<Object> get props => [doctors];
}

class DoctorSearchError extends DoctorSearchState {
  final String message;

  const DoctorSearchError(this.message);

  @override
  List<Object> get props => [message];
}
