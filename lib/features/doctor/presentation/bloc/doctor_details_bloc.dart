import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/doctor.dart';
import '../../domain/usecases/get_doctor_details_usecase.dart';
import '../../domain/usecases/toggle_favorite_usecase.dart';

part 'doctor_details_event.dart';
part 'doctor_details_state.dart';

class DoctorDetailsBloc extends Bloc<DoctorDetailsEvent, DoctorDetailsState> {
  final GetDoctorDetailsUseCase getDoctorDetailsUseCase;
  final ToggleFavoriteUseCase toggleFavoriteUseCase;

  DoctorDetailsBloc({
    required this.getDoctorDetailsUseCase,
    required this.toggleFavoriteUseCase,
  }) : super(const DoctorDetailsInitial()) {
    on<LoadDoctorDetails>(_onLoadDoctorDetails);
    on<ToggleDoctorFavorite>(_onToggleDoctorFavorite);
    on<ChatWithDoctor>(_onChatWithDoctor);
    on<BookAppointment>(_onBookAppointment);
    on<ShareDoctor>(_onShareDoctor);
  }

  void _onLoadDoctorDetails(
    LoadDoctorDetails event,
    Emitter<DoctorDetailsState> emit,
  ) async {
    emit(const DoctorDetailsLoading());

    final result = await getDoctorDetailsUseCase(event.doctorId);

    result.fold(
      (failure) => emit(DoctorDetailsError(_mapFailureToMessage(failure))),
      (doctor) => emit(DoctorDetailsLoaded(doctor, isFavorite: false)),
    );
  }

  void _onToggleDoctorFavorite(
    ToggleDoctorFavorite event,
    Emitter<DoctorDetailsState> emit,
  ) async {
    if (state is DoctorDetailsLoaded) {
      final currentState = state as DoctorDetailsLoaded;

      final result = await toggleFavoriteUseCase(event.doctorId);

      result.fold(
        (failure) => emit(DoctorDetailsError(_mapFailureToMessage(failure))),
        (_) =>
            emit(currentState.copyWith(isFavorite: !currentState.isFavorite)),
      );
    }
  }

  void _onChatWithDoctor(
    ChatWithDoctor event,
    Emitter<DoctorDetailsState> emit,
  ) {
    // Navigate to chat screen
    emit(const DoctorNavigation('/chat'));
  }

  void _onBookAppointment(
    BookAppointment event,
    Emitter<DoctorDetailsState> emit,
  ) {
    // Navigate to appointment booking
    emit(const DoctorNavigation('/appointment'));
  }

  void _onShareDoctor(
    ShareDoctor event,
    Emitter<DoctorDetailsState> emit,
  ) {
    // Handle share functionality
    emit(const DoctorShared());
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      case NetworkFailure:
        return 'تحقق من اتصالك بالإنترنت';
      case CacheFailure:
        return 'حدث خطأ في التخزين المؤقت';
      default:
        return 'حدث خطأ غير متوقع';
    }
  }
}
