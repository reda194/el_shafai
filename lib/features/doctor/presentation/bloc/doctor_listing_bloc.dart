import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/doctor.dart';
import '../../domain/entities/price_range.dart';
import '../../domain/usecases/get_doctors_usecase.dart';
import '../../domain/usecases/search_doctors_usecase.dart';

part 'doctor_listing_event.dart';
part 'doctor_listing_state.dart';

class DoctorListingBloc extends Bloc<DoctorListingEvent, DoctorListingState> {
  final GetDoctorsUseCase getDoctorsUseCase;
  final SearchDoctorsUseCase searchDoctorsUseCase;

  DoctorListingBloc({
    required this.getDoctorsUseCase,
    required this.searchDoctorsUseCase,
  }) : super(const DoctorListingInitial()) {
    on<LoadDoctors>(_onLoadDoctors);
    on<SearchDoctors>(_onSearchDoctors);
    on<FilterDoctors>(_onFilterDoctors);
    on<SortDoctors>(_onSortDoctors);
  }

  void _onLoadDoctors(
    LoadDoctors event,
    Emitter<DoctorListingState> emit,
  ) async {
    emit(const DoctorListingLoading());

    final result = await getDoctorsUseCase(const GetDoctorsParams());

    result.fold(
      (failure) => emit(DoctorListingError(_mapFailureToMessage(failure))),
      (doctors) => emit(DoctorListingLoaded(doctors)),
    );
  }

  void _onSearchDoctors(
    SearchDoctors event,
    Emitter<DoctorListingState> emit,
  ) async {
    if (event.query.isEmpty) {
      add(const LoadDoctors());
      return;
    }

    emit(const DoctorListingLoading());

    final result = await searchDoctorsUseCase(event.query);

    result.fold(
      (failure) => emit(DoctorListingError(_mapFailureToMessage(failure))),
      (doctors) => emit(DoctorListingLoaded(doctors, searchQuery: event.query)),
    );
  }

  void _onFilterDoctors(
    FilterDoctors event,
    Emitter<DoctorListingState> emit,
  ) async {
    emit(const DoctorListingLoading());

    final result = await getDoctorsUseCase(
      GetDoctorsParams(
        specialty: event.specialty,
        location: event.location,
        minRating: event.minRating,
        priceRange: event.priceRange,
      ),
    );

    result.fold(
      (failure) => emit(DoctorListingError(_mapFailureToMessage(failure))),
      (doctors) => emit(DoctorListingLoaded(
        doctors,
        specialty: event.specialty,
        location: event.location,
        minRating: event.minRating,
        priceRange: event.priceRange,
      )),
    );
  }

  void _onSortDoctors(
    SortDoctors event,
    Emitter<DoctorListingState> emit,
  ) async {
    if (state is DoctorListingLoaded) {
      final currentState = state as DoctorListingLoaded;
      final sortedDoctors = _sortDoctors(currentState.doctors, event.sortBy);

      emit(currentState.copyWith(
        doctors: sortedDoctors,
        sortBy: event.sortBy,
      ));
    }
  }

  List<Doctor> _sortDoctors(List<Doctor> doctors, String sortBy) {
    final sortedList = List<Doctor>.from(doctors);

    switch (sortBy) {
      case 'rating':
        sortedList.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'experience':
        sortedList
            .sort((a, b) => b.experienceYears.compareTo(a.experienceYears));
        break;
      case 'price_low':
        sortedList.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high':
        sortedList.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'reviews':
        sortedList.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
        break;
      default:
        // Keep current order
        break;
    }

    return sortedList;
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
