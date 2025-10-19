import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/usecases/forgot_password_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../../domain/usecases/social_sign_in_usecase.dart';

// Re-export SocialProvider for use in part files
export '../../domain/usecases/social_sign_in_usecase.dart' show SocialProvider;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SocialSignInUseCase socialSignInUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.socialSignInUseCase,
    required this.forgotPasswordUseCase,
    required this.resetPasswordUseCase,
  }) : super(const AuthInitial()) {
    on<SignInWithEmailRequested>(_onSignInWithEmailRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SocialSignInRequested>(_onSocialSignInRequested);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
    on<NavigationRequested>(_onNavigationRequested);
    on<AuthResetRequested>(_onAuthResetRequested);
  }

  void _onSignInWithEmailRequested(
    SignInWithEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await signInUseCase(
      SignInParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthFailure(_mapFailureToMessage(failure))),
      (authResponse) => emit(const AuthSuccess()),
    );
  }

  void _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await signUpUseCase(
      SignUpParams(
        email: event.email,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
        phoneNumber: event.phoneNumber,
      ),
    );

    result.fold(
      (failure) => emit(AuthFailure(_mapFailureToMessage(failure))),
      (authResponse) => emit(const AuthSuccess()),
    );
  }

  void _onSocialSignInRequested(
    SocialSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await socialSignInUseCase(
      SocialSignInParams(provider: event.provider),
    );

    result.fold(
      (failure) => emit(AuthFailure(_mapFailureToMessage(failure))),
      (authResponse) => emit(const AuthSuccess()),
    );
  }

  void _onForgotPasswordRequested(
    ForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await forgotPasswordUseCase(event.email);

    result.fold(
      (failure) => emit(AuthFailure(_mapFailureToMessage(failure))),
      (_) => emit(const AuthEmailSent()),
    );
  }

  void _onResetPasswordRequested(
    ResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await resetPasswordUseCase(
      ResetPasswordParams(token: event.token, newPassword: event.newPassword),
    );

    result.fold(
      (failure) => emit(AuthFailure(_mapFailureToMessage(failure))),
      (_) => emit(const AuthPasswordReset()),
    );
  }

  void _onNavigationRequested(
    NavigationRequested event,
    Emitter<AuthState> emit,
  ) {
    switch (event.destination) {
      case AuthDestination.signUp:
        emit(const AuthSignUpNavigation());
        break;
      case AuthDestination.signIn:
        emit(const AuthSignInNavigation());
        break;
      case AuthDestination.forgotPassword:
        emit(const AuthForgotPasswordNavigation());
        break;
      case AuthDestination.checkEmail:
        emit(const AuthCheckEmailNavigation());
        break;
      case AuthDestination.resetPassword:
        emit(const AuthResetPasswordNavigation());
        break;
      case AuthDestination.createNewPassword:
        emit(const AuthCreateNewPasswordNavigation());
        break;
      case AuthDestination.emailAuth:
        emit(const AuthEmailNavigation());
        break;
    }
  }

  void _onAuthResetRequested(
    AuthResetRequested event,
    Emitter<AuthState> emit,
  ) {
    emit(const AuthInitial());
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      case NetworkFailure:
        return 'تحقق من اتصالك بالإنترنت';
      case CacheFailure:
        return 'حدث خطأ في التخزين المؤقت';
      default:
        return 'حدث خطأ غير متوقع';
    }
  }
}
