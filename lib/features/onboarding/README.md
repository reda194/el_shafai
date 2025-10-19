# 🎯 Onboarding Feature - Clean Architecture Implementation

## 📋 **نظرة عامة**

ميزة التأهيل الأولي (Onboarding) في تطبيق شفا تقدم تجربة مستخدم سلسة للمستخدمين الجدد. تشمل الميزة:
- سلسلة من الشاشات التوضيحية
- جمع معلومات المستخدم الأساسية
- تخصيص التجربة
- تخطي الخطوات اختيارياً
- حفظ حالة التقدم

## 🏗️ **هيكل الميزة**

```
lib/features/onboarding/
├── domain/
│   ├── entities/
│   │   ├── onboarding_page.dart               # كيان صفحة التأهيل
│   │   ├── user_preferences.dart              # كيان تفضيلات المستخدم
│   │   └── onboarding_progress.dart           # كيان تقدم التأهيل
│   ├── repositories/
│   │   └── onboarding_repository.dart         # واجهة المستودع
│   └── usecases/
│       ├── get_onboarding_pages_usecase.dart  # حالة استخدام الصفحات
│       ├── save_user_preferences_usecase.dart # حالة استخدام حفظ التفضيلات
│       ├── complete_onboarding_usecase.dart   # حالة استخدام إكمال التأهيل
│       └── skip_onboarding_usecase.dart       # حالة استخدام تخطي التأهيل
├── data/
│   ├── models/
│   │   ├── onboarding_page_model.dart         # نموذج صفحة التأهيل
│   │   └── user_preferences_model.dart        # نموذج تفضيلات المستخدم
│   ├── datasources/
│   │   ├── onboarding_remote_datasource.dart  # مصدر البيانات عن بعد
│   │   └── onboarding_local_datasource.dart   # مصدر البيانات المحلي
│   └── repositories/
│       └── onboarding_repository_impl.dart    # تنفيذ المستودع
└── presentation/
    ├── bloc/
    │   ├── onboarding_bloc.dart               # منطق العرض الرئيسي
    │   ├── onboarding_event.dart
    │   └── onboarding_state.dart
    ├── pages/
    │   ├── onboarding_flow.dart               # تدفق التأهيل الرئيسي
    │   ├── onboarding_screen_1.dart           # الشاشة الأولى
    │   ├── onboarding_screen_2.dart           # الشاشة الثانية
    │   └── onboarding_screen_6.dart           # الشاشة الأخيرة
    └── widgets/
        ├── onboarding_page.dart               # مكون صفحة التأهيل
        └── page_indicator.dart                # مؤشر الصفحات
```

## 🔄 **تدفق الميزة**

### **1. التحقق من حالة التأهيل**
```dart
// في App initialization
final isOnboardingCompleted = await checkOnboardingStatus();

if (!isOnboardingCompleted) {
  // Navigate to onboarding flow
  context.go(RouteNames.onboarding);
} else {
  // Navigate to home or login
  context.go(RouteNames.welcome);
}
```

### **2. تدفق الصفحات**
```dart
// في OnboardingFlow
final pageController = PageController();

@override
Widget build(BuildContext context) {
  return BlocProvider(
    create: (context) => getIt<OnboardingBloc>()..add(const LoadOnboardingPages()),
    child: Scaffold(
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          if (state is OnboardingLoading) {
            return const OnboardingSkeleton();
          }

          if (state is OnboardingLoaded) {
            return PageView.builder(
              controller: pageController,
              itemCount: state.pages.length,
              onPageChanged: (index) {
                context.read<OnboardingBloc>().add(
                  PageChanged(index),
                );
              },
              itemBuilder: (context, index) {
                return OnboardingPageWidget(
                  page: state.pages[index],
                  onNext: () => _nextPage(),
                  onSkip: () => _skipOnboarding(),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    ),
  );
}
```

### **3. جمع تفضيلات المستخدم**
```dart
// في OnboardingBloc
void _onUserPreferencesSubmitted(
  UserPreferencesSubmitted event,
  Emitter<OnboardingState> emit,
) async {
  emit(const OnboardingSaving());

  final result = await saveUserPreferencesUseCase(
    SaveUserPreferencesParams(
      preferredLanguage: event.language,
      notificationsEnabled: event.notificationsEnabled,
      locationEnabled: event.locationEnabled,
      healthGoals: event.healthGoals,
    ),
  );

  result.fold(
    (failure) => emit(OnboardingError(_mapFailureToMessage(failure))),
    (_) => emit(const OnboardingCompleted()),
  );
}
```

## 🏭 **Dependency Injection**

### **تسجيل التبعيات في GetIt**

```dart
// في dependency_injection.dart
// Remote DataSource
getIt.registerLazySingleton<OnboardingRemoteDataSource>(
  () => OnboardingRemoteDataSourceImpl(apiClient: getIt()),
);

// Local DataSource
getIt.registerLazySingleton<OnboardingLocalDataSource>(
  () => OnboardingLocalDataSourceImpl(sharedPreferences: getIt()),
);

// Repository
getIt.registerLazySingleton<OnboardingRepository>(
  () => OnboardingRepositoryImpl(
    remoteDataSource: getIt(),
    localDataSource: getIt(),
    networkInfo: getIt(),
  ),
);

// UseCases
getIt.registerLazySingleton(() => GetOnboardingPagesUseCase(getIt()));
getIt.registerLazySingleton(() => SaveUserPreferencesUseCase(getIt()));
getIt.registerLazySingleton(() => CompleteOnboardingUseCase(getIt()));
getIt.registerLazySingleton(() => SkipOnboardingUseCase(getIt()));

// Bloc
getIt.registerFactory(
  () => OnboardingBloc(
    getOnboardingPagesUseCase: getIt(),
    saveUserPreferencesUseCase: getIt(),
    completeOnboardingUseCase: getIt(),
    skipOnboardingUseCase: getIt(),
  ),
);
```

## 📱 **استخدام في الواجهة**

### **OnboardingFlow الرئيسي**

```dart
class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Load onboarding data
    context.read<OnboardingBloc>().add(const LoadOnboardingPages());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingCompleted) {
          // Navigate to home or login
          context.go(RouteNames.welcome);
        } else if (state is OnboardingSkipped) {
          // Navigate to home with limited features
          context.go(RouteNames.welcome);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.onboardingBackground,
        body: SafeArea(
          child: BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              if (state is OnboardingLoading) {
                return const OnboardingLoadingView();
              }

              if (state is OnboardingLoaded) {
                return Column(
                  children: [
                    // Skip Button
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          context.read<OnboardingBloc>().add(const SkipOnboarding());
                        },
                        child: const Text(
                          'تخطي',
                          style: TextStyle(
                            fontFamily: 'IBM Plex Sans Arabic',
                            color: AppColors.primary,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    // Page View
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: state.pages.length,
                        onPageChanged: (index) {
                          setState(() => _currentPage = index);
                          context.read<OnboardingBloc>().add(PageChanged(index));
                        },
                        itemBuilder: (context, index) {
                          return OnboardingPage(
                            page: state.pages[index],
                            onNext: () => _nextPage(state.pages.length),
                            onGetStarted: () => _completeOnboarding(),
                          );
                        },
                      ),
                    ),

                    // Page Indicator
                    PageIndicator(
                      currentPage: _currentPage,
                      totalPages: state.pages.length,
                    ),

                    const SizedBox(height: 20),
                  ],
                );
              }

              if (state is OnboardingError) {
                return OnboardingErrorView(
                  message: state.message,
                  onRetry: () {
                    context.read<OnboardingBloc>().add(const LoadOnboardingPages());
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  void _nextPage(int totalPages) {
    if (_currentPage < totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() {
    context.read<OnboardingBloc>().add(const CompleteOnboarding());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
```

### **OnboardingPage Component**

```dart
class OnboardingPage extends StatelessWidget {
  final OnboardingPageEntity page;
  final VoidCallback onNext;
  final VoidCallback? onGetStarted;

  const OnboardingPage({
    super.key,
    required this.page,
    required this.onNext,
    this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(140),
            ),
            child: Center(
              child: SvgPicture.asset(
                page.imageUrl,
                width: 200,
                height: 200,
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Title
          Text(
            page.title,
            style: const TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // Subtitle
          Text(
            page.subtitle,
            style: const TextStyle(
              fontFamily: 'IBM Plex Sans Arabic',
              fontSize: 16,
              color: AppColors.onboardingTextSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 48),

          // Action Button
          if (page.isLastPage)
            PrimaryButton(
              text: 'ابدأ الآن',
              onPressed: onGetStarted ?? onNext,
            )
          else
            PrimaryButton(
              text: 'التالي',
              onPressed: onNext,
            ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
```

### **PageIndicator Component**

```dart
class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == index
                ? AppColors.primary
                : AppColors.primary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
```

## 🔄 **إدارة الحالة**

### **OnboardingBloc Implementation**

```dart
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final GetOnboardingPagesUseCase getOnboardingPagesUseCase;
  final SaveUserPreferencesUseCase saveUserPreferencesUseCase;
  final CompleteOnboardingUseCase completeOnboardingUseCase;
  final SkipOnboardingUseCase skipOnboardingUseCase;

  OnboardingBloc({
    required this.getOnboardingPagesUseCase,
    required this.saveUserPreferencesUseCase,
    required this.completeOnboardingUseCase,
    required this.skipOnboardingUseCase,
  }) : super(const OnboardingInitial()) {
    on<LoadOnboardingPages>(_onLoadOnboardingPages);
    on<PageChanged>(_onPageChanged);
    on<UserPreferencesSubmitted>(_onUserPreferencesSubmitted);
    on<CompleteOnboarding>(_onCompleteOnboarding);
    on<SkipOnboarding>(_onSkipOnboarding);
  }

  Future<void> _onLoadOnboardingPages(
    LoadOnboardingPages event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(const OnboardingLoading());

    final result = await getOnboardingPagesUseCase(NoParams());

    result.fold(
      (failure) => emit(OnboardingError(_mapFailureToMessage(failure))),
      (pages) => emit(OnboardingLoaded(pages: pages, currentPage: 0)),
    );
  }

  void _onPageChanged(
    PageChanged event,
    Emitter<OnboardingState> emit,
  ) {
    if (state is OnboardingLoaded) {
      final currentState = state as OnboardingLoaded;
      emit(currentState.copyWith(currentPage: event.pageIndex));
    }
  }

  Future<void> _onUserPreferencesSubmitted(
    UserPreferencesSubmitted event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(const OnboardingSaving());

    final result = await saveUserPreferencesUseCase(
      SaveUserPreferencesParams(
        preferredLanguage: event.preferredLanguage,
        notificationsEnabled: event.notificationsEnabled,
        locationEnabled: event.locationEnabled,
        healthGoals: event.healthGoals,
      ),
    );

    result.fold(
      (failure) => emit(OnboardingError(_mapFailureToMessage(failure))),
      (_) => emit(const OnboardingPreferencesSaved()),
    );
  }

  Future<void> _onCompleteOnboarding(
    CompleteOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    final result = await completeOnboardingUseCase(NoParams());

    result.fold(
      (failure) => emit(OnboardingError(_mapFailureToMessage(failure))),
      (_) => emit(const OnboardingCompleted()),
    );
  }

  Future<void> _onSkipOnboarding(
    SkipOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    final result = await skipOnboardingUseCase(NoParams());

    result.fold(
      (failure) => emit(OnboardingError(_mapFailureToMessage(failure))),
      (_) => emit(const OnboardingSkipped()),
    );
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
```

## 🎨 **تخصيص تجربة المستخدم**

### **تخزين تفضيلات المستخدم**

```dart
// في UserPreferences entity
class UserPreferences {
  final String preferredLanguage;
  final bool notificationsEnabled;
  final bool locationEnabled;
  final List<String> healthGoals;
  final Map<String, dynamic> customSettings;

  const UserPreferences({
    required this.preferredLanguage,
    required this.notificationsEnabled,
    required this.locationEnabled,
    required this.healthGoals,
    this.customSettings = const {},
  });
}
```

### **تخصيص المحتوى**

```dart
// في OnboardingRepository
Future<Either<Failure, List<OnboardingPageEntity>>> getPersonalizedPages({
  required String userType,
  required String preferredLanguage,
}) async {
  // Return different pages based on user type and preferences
  switch (userType) {
    case 'patient':
      return await _getPatientOnboardingPages(preferredLanguage);
    case 'doctor':
      return await _getDoctorOnboardingPages(preferredLanguage);
    default:
      return await _getDefaultOnboardingPages(preferredLanguage);
  }
}
```

## 🧪 **اختبار الميزة**

### **اختبار OnboardingBloc**

```dart
blocTest<OnboardingBloc, OnboardingState>(
  'emits [OnboardingLoading, OnboardingLoaded] when LoadOnboardingPages is added',
  build: () => onboardingBloc,
  act: (bloc) => bloc.add(const LoadOnboardingPages()),
  expect: () => [
    const OnboardingLoading(),
    OnboardingLoaded(pages: mockPages, currentPage: 0),
  ],
);
```

### **اختبار OnboardingPage**

```dart
void main() {
  testWidgets('OnboardingPage displays title and subtitle correctly',
      (WidgetTester tester) async {
    // Arrange
    const mockPage = OnboardingPageEntity(
      title: 'Test Title',
      subtitle: 'Test Subtitle',
      imageUrl: 'test.png',
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: OnboardingPage(
          page: mockPage,
          onNext: () {},
        ),
      ),
    );

    // Assert
    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Subtitle'), findsOneWidget);
  });
}
```

## 🚀 **نصائح التطوير**

1. **الأداء**: استخدم precaching للصور والمحتوى
2. **إمكانية الوصول**: أضف دعم للـ screen readers
3. **التخصيص**: اجعل التأهيل قابل للتخصيص حسب نوع المستخدم
4. **التحليلات**: أضف tracking لمعرفة معدلات الإكمال
5. **اللغات**: دعم متعدد اللغات من البداية
6. **التخطي**: اجعل التخطي سهل ولكن غير مشجع عليه

## 📚 **المتطلبات**

### **Dependencies في pubspec.yaml**

```yaml
dependencies:
  flutter_bloc: ^8.1.4
  equatable: ^2.0.5
  dartz: ^0.10.1
  shared_preferences: ^2.2.2
  smooth_page_indicator: ^1.0.0

dev_dependencies:
  bloc_test: ^9.1.6
  mockito: ^5.4.4
```

## 🔗 **التكامل مع الميزات الأخرى**

- **Authentication**: التنقل إلى تسجيل الدخول بعد إكمال التأهيل
- **Home**: تخصيص الصفحة الرئيسية بناءً على تفضيلات المستخدم
- **Settings**: استخدام تفضيلات المستخدم المحفوظة
- **Analytics**: تتبع سلوك المستخدم أثناء التأهيل
