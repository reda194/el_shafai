import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/medical_category.dart';
import '../repositories/home_repository.dart';

class GetMedicalCategoriesUseCase
    implements UseCase<List<MedicalCategory>, NoParams> {
  final HomeRepository repository;

  GetMedicalCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<MedicalCategory>>> call(NoParams params) async {
    return await repository.getMedicalCategories();
  }
}
