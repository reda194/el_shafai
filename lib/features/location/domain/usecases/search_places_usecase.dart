import 'package:dartz/dartz.dart';
import 'package:neurocare_app/core/errors/failures.dart';
import 'package:neurocare_app/core/usecases/usecase.dart';
import 'package:neurocare_app/features/location/domain/entities/location_entity.dart';
import 'package:neurocare_app/features/location/domain/repositories/location_repository.dart';

class SearchPlacesUseCase
    implements UseCase<List<PlaceEntity>, SearchPlacesParams> {
  final LocationRepository repository;

  SearchPlacesUseCase(this.repository);

  @override
  Future<Either<Failure, List<PlaceEntity>>> call(SearchPlacesParams params) {
    return repository.searchPlaces(params.query);
  }
}

class SearchPlacesParams {
  final String query;

  const SearchPlacesParams({
    required this.query,
  });
}
