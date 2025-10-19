part of 'doctor_listing_bloc.dart';

abstract class DoctorListingEvent extends Equatable {
  const DoctorListingEvent();

  @override
  List<Object> get props => [];
}

class LoadDoctors extends DoctorListingEvent {
  const LoadDoctors();
}

class SearchDoctors extends DoctorListingEvent {
  final String query;

  const SearchDoctors(this.query);

  @override
  List<Object> get props => [query];
}

class FilterDoctors extends DoctorListingEvent {
  final String? specialty;
  final String? location;
  final double? minRating;
  final PriceRange? priceRange;

  const FilterDoctors({
    this.specialty,
    this.location,
    this.minRating,
    this.priceRange,
  });

  @override
  List<Object> get props => [
        specialty ?? '',
        location ?? '',
        minRating ?? 0.0,
        priceRange ?? const PriceRange(start: 0, end: 0)
      ];
}

class SortDoctors extends DoctorListingEvent {
  final String sortBy;

  const SortDoctors(this.sortBy);

  @override
  List<Object> get props => [sortBy];
}
