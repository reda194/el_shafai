part of 'doctor_details_bloc.dart';

abstract class DoctorDetailsEvent extends Equatable {
  const DoctorDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadDoctorDetails extends DoctorDetailsEvent {
  final String doctorId;

  const LoadDoctorDetails(this.doctorId);

  @override
  List<Object> get props => [doctorId];
}

class ToggleDoctorFavorite extends DoctorDetailsEvent {
  final String doctorId;

  const ToggleDoctorFavorite(this.doctorId);

  @override
  List<Object> get props => [doctorId];
}

class ChatWithDoctor extends DoctorDetailsEvent {
  const ChatWithDoctor();
}

class BookAppointment extends DoctorDetailsEvent {
  const BookAppointment();
}

class ShareDoctor extends DoctorDetailsEvent {
  const ShareDoctor();
}
