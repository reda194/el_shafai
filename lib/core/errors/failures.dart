import 'package:equatable/equatable.dart';

/// Base failure class for all domain errors
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Server failure when API call fails
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Cache failure when local storage fails
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Network failure when there's no internet connection
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Validation failure for invalid input data
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Authentication failure when user is not authenticated
class AuthenticationFailure extends Failure {
  const AuthenticationFailure(super.message);
}

/// Authorization failure when user doesn't have permission
class AuthorizationFailure extends Failure {
  const AuthorizationFailure(super.message);
}

/// Not found failure when requested resource doesn't exist
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

/// Conflict failure when there's a conflict (e.g., time slot already taken)
class ConflictFailure extends Failure {
  const ConflictFailure(super.message);
}
