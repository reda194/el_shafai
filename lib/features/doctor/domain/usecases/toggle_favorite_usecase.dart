import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/doctor_repository.dart';

class ToggleFavoriteUseCase implements UseCase<void, String> {
  final DoctorRepository repository;

  ToggleFavoriteUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String doctorId) async {
    // First check if doctor is favorite
    final isFavoriteResult = await repository.isDoctorFavorite(doctorId);

    if (isFavoriteResult.isLeft()) {
      return isFavoriteResult;
    }

    final isFavorite = isFavoriteResult.getOrElse(() => false);

    if (isFavorite) {
      return repository.removeFromFavorites(doctorId);
    } else {
      return repository.addToFavorites(doctorId);
    }
  }
}
