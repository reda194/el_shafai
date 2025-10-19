part of 'doctor_cubit.dart';

abstract class DoctorState extends Equatable {
  const DoctorState();

  @override
  List<Object> get props => [];
}

class DoctorInitial extends DoctorState {
  const DoctorInitial();
}

class DoctorLoading extends DoctorState {
  const DoctorLoading();
}

class DoctorLoaded extends DoctorState {
  final Doctor doctor;
  final int selectedTabIndex;
  final bool isFavorite;

  const DoctorLoaded(
    this.doctor, {
    this.selectedTabIndex = 0,
    this.isFavorite = false,
  });

  DoctorLoaded copyWith({
    Doctor? doctor,
    int? selectedTabIndex,
    bool? isFavorite,
  }) {
    return DoctorLoaded(
      doctor ?? this.doctor,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object> get props => [doctor, selectedTabIndex, isFavorite];
}

class DoctorError extends DoctorState {
  final String message;

  const DoctorError(this.message);

  @override
  List<Object> get props => [message];
}

class DoctorNavigation extends DoctorState {
  final String route;

  const DoctorNavigation(this.route);

  @override
  List<Object> get props => [route];
}

class DoctorShared extends DoctorState {
  const DoctorShared();
}
