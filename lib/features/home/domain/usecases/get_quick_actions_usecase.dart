import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/quick_action.dart';
import '../repositories/home_repository.dart';

class GetQuickActionsUseCase implements UseCase<List<QuickAction>, NoParams> {
  final HomeRepository repository;

  GetQuickActionsUseCase(this.repository);

  @override
  Future<Either<Failure, List<QuickAction>>> call(NoParams params) async {
    return await repository.getQuickActions();
  }
}
