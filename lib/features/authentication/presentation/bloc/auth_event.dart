part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInWithEmailRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInWithEmailRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;

  const SignUpRequested({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [email, password, firstName, lastName, phoneNumber];
}

class SocialSignInRequested extends AuthEvent {
  final SocialProvider provider;

  const SocialSignInRequested({required this.provider});

  @override
  List<Object> get props => [provider];
}

class ForgotPasswordRequested extends AuthEvent {
  final String email;

  const ForgotPasswordRequested(this.email);

  @override
  List<Object> get props => [email];
}

class ResetPasswordRequested extends AuthEvent {
  final String token;
  final String newPassword;

  const ResetPasswordRequested({
    required this.token,
    required this.newPassword,
  });

  @override
  List<Object> get props => [token, newPassword];
}

enum AuthDestination {
  signUp,
  signIn,
  forgotPassword,
  checkEmail,
  resetPassword,
  createNewPassword,
  emailAuth,
}

class NavigationRequested extends AuthEvent {
  final AuthDestination destination;

  const NavigationRequested(this.destination);

  @override
  List<Object> get props => [destination];
}

class AuthResetRequested extends AuthEvent {}
