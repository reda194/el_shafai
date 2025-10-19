import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:neurocare_app/core/errors/failures.dart';

/// Abstract base class for all use cases
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Base class for use case parameters
abstract class Params extends Equatable {}

/// No parameters class for use cases that don't need parameters
class NoParams extends Params {
  @override
  List<Object?> get props => [];
}
