# 🔐 Authentication Feature - Clean Architecture Implementation

## 📋 **نظرة عامة**

ميزة المصادقة في تطبيق شفا تطبق Clean Architecture مع طبقات واضحة للفصل بين الاهتمامات. تدعم الميزة:
- تسجيل الدخول بالبريد الإلكتروني وكلمة المرور
- إنشاء حساب جديد
- تسجيل الدخول الاجتماعي (Google, Apple, Facebook)
- إعادة تعيين كلمة المرور
- إدارة الجلسات والرموز المميزة

## 🏗️ **هيكل الميزة**

```
lib/features/authentication/
├── domain/
│   ├── entities/
│   │   ├── user_entity.dart              # كيان المستخدم
│   │   └── auth_response_entity.dart     # كيان استجابة المصادقة
│   ├── repositories/
│   │   └── auth_repository.dart          # واجهة المستودع
│   └── usecases/
│       ├── sign_in_usecase.dart          # حالة استخدام تسجيل الدخول
│       ├── sign_up_usecase.dart          # حالة استخدام إنشاء الحساب
│       ├── social_sign_in_usecase.dart   # حالة استخدام تسجيل الدخول الاجتماعي
│       ├── forgot_password_usecase.dart  # حالة استخدام نسيان كلمة المرور
│       └── reset_password_usecase.dart   # حالة استخدام إعادة تعيين كلمة المرور
├── data/
│   ├── models/
│   │   ├── user_model.dart               # نموذج المستخدم
│   │   └── auth_response_model.dart      # نموذج استجابة المصادقة
│   ├── datasources/
│   │   ├── auth_remote_datasource.dart   # مصدر البيانات عن بعد
│   │   └── auth_local_datasource.dart    # مصدر البيانات المحلي
│   └── repositories/
│       └── auth_repository_impl.dart     # تنفيذ المستودع
└── presentation/
    ├── bloc/
    │   ├── auth_bloc.dart                # منطق العرض الرئيسي
    │   ├── auth_event.dart               # أحداث BLoC
    │   └── auth_state.dart               # حالات BLoC
    └── pages/                            # صفحات واجهة المستخدم
```

## 🔄 **تدفق المصادقة**

### **1. تسجيل الدخول**
```dart
// في Presentation Layer
context.read<AuthBloc>().add(
  SignInWithEmailRequested(
    email: email,
    password: password,
  ),
);

// يتم التعامل مع النتيجة في Bloc
result.fold(
  (failure) => emit(AuthFailure(_mapFailureToMessage(failure))),
  (authResponse) => emit(const AuthSuccess()),
);
```

### **2. إنشاء حساب جديد**
```dart
context.read<AuthBloc>().add(
  SignUpRequested(
    email: email,
    password: password,
    firstName: firstName,
    lastName: lastName,
    phoneNumber: phoneNumber,
  ),
);
```

### **3. تسجيل الدخول الاجتماعي**
```dart
context.read<AuthBloc>().add(
  SocialSignInRequested(provider: SocialProvider.google),
);
```

## 🏭 **Dependency Injection**

### **تسجيل التبعيات في GetIt**

```dart
// في dependency_injection.dart
// Remote DataSource
getIt.registerLazySingleton<AuthRemoteDataSource>(
  () => AuthRemoteDataSourceImpl(apiClient: getIt()),
);

// Local DataSource
getIt.registerLazySingleton<AuthLocalDataSource>(
  () => AuthLocalDataSourceImpl(sharedPreferences: getIt()),
);

// Repository
getIt.registerLazySingleton<AuthRepository>(
  () => AuthRepositoryImpl(
    remoteDataSource: getIt(),
    localDataSource: getIt(),
    networkInfo: getIt(),
  ),
);

// UseCases
getIt.registerLazySingleton(() => SignInUseCase(getIt()));
getIt.registerLazySingleton(() => SignUpUseCase(getIt()));
getIt.registerLazySingleton(() => SocialSignInUseCase(getIt()));
getIt.registerLazySingleton(() => ForgotPasswordUseCase(getIt()));
getIt.registerLazySingleton(() => ResetPasswordUseCase(getIt()));

// Bloc
getIt.registerFactory(
  () => AuthBloc(
    signInUseCase: getIt(),
    signUpUseCase: getIt(),
    socialSignInUseCase: getIt(),
    forgotPasswordUseCase: getIt(),
    resetPasswordUseCase: getIt(),
  ),
);
```

## 📱 **استخدام في الواجهة**

### **BlocBuilder للاستماع للتغييرات**

```dart
BlocBuilder<AuthBloc, AuthState>(
  builder: (context, state) {
    if (state is AuthLoading) {
      return const CircularProgressIndicator();
    }

    if (state is AuthSuccess) {
      // Navigate to home
      return const HomeScreen();
    }

    if (state is AuthFailure) {
      return Text(state.message);
    }

    return const LoginForm();
  },
)
```

### **BlocListener للتنقل**

```dart
BlocListener<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is AuthSignUpNavigation) {
      context.go(RouteNames.register);
    } else if (state is AuthSuccess) {
      context.go(RouteNames.home);
    }
  },
  child: const LoginForm(),
)
```

## 🔒 **إدارة الأمان**

### **تخزين الرموز المميزة**

```dart
// في AuthLocalDataSourceImpl
Future<void> saveAccessToken(String token) async {
  await sharedPreferences.setString('access_token', token);
}

Future<String?> getAccessToken() async {
  return sharedPreferences.getString('access_token');
}
```

### **تحقق من المصادقة**

```dart
Future<bool> isAuthenticated() async {
  final token = await getAccessToken();
  return token != null && token.isNotEmpty;
}
```

## 🧪 **اختبار الميزة**

### **اختبار UseCase**

```dart
void main() {
  test('should return AuthResponseEntity when sign in succeeds', () async {
    // Arrange
    when(mockRepository.signInWithEmailAndPassword(
      email: 'test@example.com',
      password: 'password123',
    )).thenAnswer((_) async => Right(mockAuthResponse));

    // Act
    final result = await signInUseCase(
      SignInParams(email: 'test@example.com', password: 'password123'),
    );

    // Assert
    expect(result, Right(mockAuthResponse));
  });
}
```

### **اختبار Bloc**

```dart
blocTest<AuthBloc, AuthState>(
  'emits [AuthLoading, AuthSuccess] when sign in succeeds',
  build: () => authBloc,
  act: (bloc) => bloc.add(SignInWithEmailRequested(
    email: 'test@example.com',
    password: 'password123',
  )),
  expect: () => [
    const AuthLoading(),
    const AuthSuccess(),
  ],
);
```

## 🚀 **نصائح التطوير**

1. **التحقق من صحة البيانات**: استخدم Form validation في الواجهة
2. **إدارة الأخطاء**: استخدم proper error handling في جميع الطبقات
3. **التخزين الآمن**: استخدم secure storage للرموز المميزة الحساسة
4. **إدارة الجلسات**: طبق token refresh mechanism
5. **UX**: أضف loading states و error messages واضحة

## 📚 **المتطلبات**

### **Dependencies في pubspec.yaml**

```yaml
dependencies:
  flutter_bloc: ^8.1.4
  equatable: ^2.0.5
  dartz: ^0.10.1
  shared_preferences: ^2.2.2
  # Dio أو http package للـ API calls

dev_dependencies:
  bloc_test: ^9.1.6
  mockito: ^5.4.4
```

## 🔗 **التكامل مع الميزات الأخرى**

- **Home**: بعد تسجيل الدخول الناجح، انتقل إلى HomeScreen
- **Profile**: استخدم UserEntity لعرض بيانات المستخدم
- **Settings**: استخدم ChangePasswordUseCase لتغيير كلمة المرور
