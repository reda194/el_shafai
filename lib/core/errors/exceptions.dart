/// Base exception class
class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() => message;
}

/// Server exception for API errors
class ServerException extends AppException {
  ServerException(super.message);
}

/// Cache exception for local storage errors
class CacheException extends AppException {
  CacheException(super.message);
}

/// Network exception for connectivity issues
class NetworkException extends AppException {
  NetworkException(super.message);
}

/// Authentication exception
class AuthenticationException extends AppException {
  AuthenticationException(super.message);
}

/// Authorization exception
class AuthorizationException extends AppException {
  AuthorizationException(super.message);
}

/// Not found exception
class NotFoundException extends AppException {
  NotFoundException(super.message);
}

/// Validation exception
class ValidationException extends AppException {
  ValidationException(super.message);
}

/// Conflict exception
class ConflictException extends AppException {
  ConflictException(super.message);
}
