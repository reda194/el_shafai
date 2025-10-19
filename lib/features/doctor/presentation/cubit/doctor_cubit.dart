import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neurocare_app/features/doctor/domain/entities/doctor.dart';

part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(const DoctorInitial());

  void loadDoctor(String doctorId) {
    emit(const DoctorLoading());
    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      final doctor = Doctor.sample(); // In real app, fetch by ID
      emit(DoctorLoaded(doctor, selectedTabIndex: 0, isFavorite: false));
    });
  }

  void selectTab(int tabIndex) {
    if (state is DoctorLoaded) {
      final currentState = state as DoctorLoaded;
      emit(currentState.copyWith(selectedTabIndex: tabIndex));
    }
  }

  void chatWithDoctor() {
    emit(const DoctorNavigation('/chat'));
  }

  void bookAppointment() {
    emit(const DoctorNavigation('/appointment'));
  }

  void toggleFavorite() {
    if (state is DoctorLoaded) {
      final currentState = state as DoctorLoaded;
      emit(currentState.copyWith(isFavorite: !currentState.isFavorite));
    }
  }

  void shareDoctor() {
    // Implement share functionality
    emit(const DoctorShared());
  }
}
