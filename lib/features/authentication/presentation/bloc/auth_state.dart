part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  const AuthSuccess();
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}

class AuthEmailSent extends AuthState {
  const AuthEmailSent();
}

class AuthPasswordReset extends AuthState {
  const AuthPasswordReset();
}

// Navigation States
class AuthEmailNavigation extends AuthState {
  const AuthEmailNavigation();
}

class AuthSignUpNavigation extends AuthState {
  const AuthSignUpNavigation();
}

class AuthSignInNavigation extends AuthState {
  const AuthSignInNavigation();
}

class AuthForgotPasswordNavigation extends AuthState {
  const AuthForgotPasswordNavigation();
}

class AuthCheckEmailNavigation extends AuthState {
  const AuthCheckEmailNavigation();
}

class AuthResetPasswordNavigation extends AuthState {
  const AuthResetPasswordNavigation();
}

class AuthCreateNewPasswordNavigation extends AuthState {
  const AuthCreateNewPasswordNavigation();
}
