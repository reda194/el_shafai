# 🏠 Home Feature - Clean Architecture Implementation

## 📋 **نظرة عامة**

ميزة الصفحة الرئيسية في تطبيق شفا تطبق Clean Architecture لعرض لوحة التحكم الرئيسية للمستخدم. تشمل الميزة:
- عرض الفئات الطبية الرئيسية
- عرض الأطباء المميزين
- عرض نصائح الصحة
- الإجراءات السريعة
- إحصائيات لوحة التحكم
- التخصيص الشخصي

## 🏗️ **هيكل الميزة**

```
lib/features/home/
├── domain/
│   ├── entities/
│   │   ├── medical_category.dart              # كيان الفئة الطبية
│   │   ├── health_tip.dart                    # كيان نصيحة الصحة
│   │   └── quick_action.dart                  # كيان الإجراء السريع
│   ├── repositories/
│   │   └── home_repository.dart               # واجهة المستودع
│   └── usecases/
│       ├── get_medical_categories_usecase.dart # حالة استخدام الفئات
│       ├── get_health_tips_usecase.dart        # حالة استخدام النصائح
│       └── get_quick_actions_usecase.dart      # حالة استخدام الإجراءات
├── data/
│   ├── models/
│   │   ├── medical_category_model.dart        # نموذج الفئة الطبية
│   │   └── health_tip_model.dart              # نموذج نصيحة الصحة
│   ├── datasources/
│   │   ├── home_remote_datasource.dart        # مصدر البيانات عن بعد
│   │   └── home_local_datasource.dart         # مصدر البيانات المحلي
│   └── repositories/
│       └── home_repository_impl.dart          # تنفيذ المستودع
└── presentation/
    ├── bloc/
    │   ├── home_bloc.dart                     # منطق العرض الرئيسي
    │   ├── home_event.dart
    │   └── home_state.dart
    ├── pages/
    │   └── home_screen.dart                   # الصفحة الرئيسية
    └── widgets/                               # مكونات واجهة المستخدم
```

## 🔄 **تدفق الميزة**

### **1. تحميل بيانات الصفحة الرئيسية**
```dart
// في HomeScreen
context.read<HomeBloc>().add(const LoadHomeData());

// الاستماع للتغييرات
BlocBuilder<HomeBloc, HomeState>(
  builder: (context, state) {
    if (state is HomeLoading) {
      return const HomeSkeletonLoading();
    }

    if (state is HomeLoaded) {
      return HomeContent(
        categories: state.categories,
        healthTips: state.healthTips,
        quickActions: state.quickActions,
      );
    }

    if (state is HomeError) {
      return HomeErrorView(message: state.message);
    }

    return const SizedBox.shrink();
  },
)
```

### **2. التفاعل مع الفئات الطبية**
```dart
// في HomeBloc
void _onCategorySelected(
  CategorySelected event,
  Emitter<HomeState> emit,
) {
  if (state is HomeLoaded) {
    final currentState = state as HomeLoaded;
    emit(currentState.copyWith(selectedCategory: event.categoryId));
  }
}
```

### **3. البحث في النصائح**
```dart
// في HomeScreen
final searchController = TextEditingController();

searchController.addListener(() {
  context.read<HomeBloc>().add(
    SearchHealthTips(searchController.text),
  );
});
```

## 🏭 **Dependency Injection**

### **تسجيل التبعيات في GetIt**

```dart
// في dependency_injection.dart
// Remote DataSource
getIt.registerLazySingleton<HomeRemoteDataSource>(
  () => HomeRemoteDataSourceImpl(apiClient: getIt()),
);

// Local DataSource
getIt.registerLazySingleton<HomeLocalDataSource>(
  () => HomeLocalDataSourceImpl(sharedPreferences: getIt()),
);

// Repository
getIt.registerLazySingleton<HomeRepository>(
  () => HomeRepositoryImpl(
    remoteDataSource: getIt(),
    localDataSource: getIt(),
    networkInfo: getIt(),
  ),
);

// UseCases
getIt.registerLazySingleton(() => GetMedicalCategoriesUseCase(getIt()));
getIt.registerLazySingleton(() => GetHealthTipsUseCase(getIt()));
getIt.registerLazySingleton(() => GetQuickActionsUseCase(getIt()));

// Bloc
getIt.registerFactory(
  () => HomeBloc(
    getMedicalCategoriesUseCase: getIt(),
    getHealthTipsUseCase: getIt(),
    getQuickActionsUseCase: getIt(),
  ),
);
```

## 📱 **استخدام في الواجهة**

### **HomeScreen الرئيسي**

```dart
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>()..add(const LoadHomeData()),
      child: Scaffold(
        appBar: HomeAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome Section
                    WelcomeSection(user: currentUser),

                    const SizedBox(height: 24),

                    // Quick Actions
                    if (state is HomeLoaded)
                      QuickActionsGrid(actions: state.quickActions),

                    const SizedBox(height: 24),

                    // Medical Categories
                    MedicalCategoriesSection(
                      categories: state is HomeLoaded ? state.categories : [],
                      onCategoryTap: (category) {
                        context.read<HomeBloc>().add(
                          CategorySelected(category.id),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    // Featured Doctors
                    FeaturedDoctorsSection(
                      doctors: state is HomeLoaded ? state.featuredDoctors : [],
                    ),

                    const SizedBox(height: 24),

                    // Health Tips
                    HealthTipsSection(
                      tips: state is HomeLoaded ? state.healthTips : [],
                      onTipTap: (tip) {
                        // Navigate to tip detail
                      },
                    ),

                    const SizedBox(height: 24),

                    // Dashboard Stats
                    DashboardStatsSection(
                      stats: state is HomeLoaded ? state.dashboardStats : {},
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      ),
    );
  }
}
```

### **مكونات الواجهة**

#### **MedicalCategoryCard**

```dart
class MedicalCategoryCard extends StatelessWidget {
  final MedicalCategory category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Category Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: SvgPicture.asset(
                  category.iconUrl,
                  width: 30,
                  height: 30,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Category Name
            Text(
              category.arabicName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 4),

            // Doctor Count
            Text(
              '${category.doctorCount} طبيب',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
```

#### **HealthTipCard**

```dart
class HealthTipCard extends StatelessWidget {
  final HealthTip tip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Tip Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(tip.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Tip Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      tip.arabicCategory,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Title
                  Text(
                    tip.arabicTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // Read Time
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${tip.readTimeMinutes} دقيقة للقراءة',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Bookmark Button
            IconButton(
              icon: Icon(
                tip.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                color: tip.isBookmarked
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              onPressed: () {
                // Toggle bookmark
                context.read<HomeBloc>().add(
                  ToggleHealthTipBookmark(tip.id),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🔄 **إدارة الحالة**

### **HomeBloc Implementation**

```dart
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMedicalCategoriesUseCase getMedicalCategoriesUseCase;
  final GetHealthTipsUseCase getHealthTipsUseCase;
  final GetQuickActionsUseCase getQuickActionsUseCase;

  HomeBloc({
    required this.getMedicalCategoriesUseCase,
    required this.getHealthTipsUseCase,
    required this.getQuickActionsUseCase,
  }) : super(const HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<CategorySelected>(_onCategorySelected);
    on<SearchHealthTips>(_onSearchHealthTips);
    on<ToggleHealthTipBookmark>(_onToggleHealthTipBookmark);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());

    final results = await Future.wait([
      getMedicalCategoriesUseCase(NoParams()),
      getHealthTipsUseCase(const GetHealthTipsParams()),
      getQuickActionsUseCase(NoParams()),
    ]);

    final categoriesResult = results[0] as Either<Failure, List<MedicalCategory>>;
    final tipsResult = results[1] as Either<Failure, List<HealthTip>>;
    final actionsResult = results[2] as Either<Failure, List<QuickAction>>;

    final combinedResult = categoriesResult.fold(
      (failure) => Left(failure),
      (categories) => tipsResult.fold(
        (failure) => Left(failure),
        (tips) => actionsResult.fold(
          (failure) => Left(failure),
          (actions) => Right([categories, tips, actions]),
        ),
      ),
    );

    combinedResult.fold(
      (failure) => emit(HomeError(_mapFailureToMessage(failure))),
      (results) => emit(HomeLoaded(
        categories: results[0] as List<MedicalCategory>,
        healthTips: results[1] as List<HealthTip>,
        quickActions: results[2] as List<QuickAction>,
        featuredDoctors: [], // Load separately if needed
        dashboardStats: {},
      )),
    );
  }

  // ... other event handlers
}
```

## 🚀 **نصائح التطوير**

1. **التخزين المؤقت**: طبق caching strategy للبيانات الثابتة نسبياً
2. **التخصيص**: استخدم user preferences لتخصيص المحتوى
3. **الأداء**: استخدم pagination للقوائم الكبيرة
4. **الـ UX**: أضف skeleton loading و smooth animations
5. **الإشعارات**: أضف push notifications للنصائح الجديدة

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

- **Authentication**: عرض المستخدم المسجل دخول
- **Doctor**: التنقل إلى قائمة الأطباء عند اختيار فئة
- **Appointments**: عرض المواعيد القادمة
- **Health Records**: عرض ملخص السجلات الصحية
- **Chat**: إشعار المحادثات الجديدة
