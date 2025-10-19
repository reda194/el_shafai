part of 'doctor_listing_bloc.dart';

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
  final String? searchQuery;
  final String? specialty;
  final String? location;
  final double? minRating;
  final PriceRange? priceRange;
  final String? sortBy;

  const DoctorListingLoaded(
    this.doctors, {
    this.searchQuery,
    this.specialty,
    this.location,
    this.minRating,
    this.priceRange,
    this.sortBy,
  });

  DoctorListingLoaded copyWith({
    List<Doctor>? doctors,
    String? searchQuery,
    String? specialty,
    String? location,
    double? minRating,
    PriceRange? priceRange,
    String? sortBy,
  }) {
    return DoctorListingLoaded(
      doctors ?? this.doctors,
      searchQuery: searchQuery ?? this.searchQuery,
      specialty: specialty ?? this.specialty,
      location: location ?? this.location,
      minRating: minRating ?? this.minRating,
      priceRange: priceRange ?? this.priceRange,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  @override
  List<Object> get props => [
        doctors,
        searchQuery ?? '',
        specialty ?? '',
        location ?? '',
        minRating ?? 0.0,
        priceRange ?? const PriceRange(start: 0, end: 0),
        sortBy ?? '',
      ];
}

class DoctorListingError extends DoctorListingState {
  final String message;

  const DoctorListingError(this.message);

  @override
  List<Object> get props => [message];
}
