# 🩺 Doctor Feature - Clean Architecture Implementation

## 📋 **نظرة عامة**

ميزة الأطباء في تطبيق شفا تطبق Clean Architecture لإدارة قائمة الأطباء، تفاصيل الأطباء، البحث، التصفية، والمفضلة. تدعم الميزة:
- عرض قائمة الأطباء مع التصفية والبحث
- عرض تفاصيل الطبيب الشاملة
- إدارة الأطباء المفضلين
- حجز المواعيد والمحادثة
- تقييم ومراجعة الأطباء

## 🏗️ **هيكل الميزة**

```
lib/features/doctor/
├── domain/
│   ├── entities/
│   │   └── doctor.dart                           # كيان الطبيب
│   ├── repositories/
│   │   └── doctor_repository.dart                # واجهة المستودع
│   └── usecases/
│       ├── get_doctors_usecase.dart              # حالة استخدام جلب الأطباء
│       ├── get_doctor_details_usecase.dart       # حالة استخدام تفاصيل الطبيب
│       ├── search_doctors_usecase.dart           # حالة استخدام البحث
│       └── toggle_favorite_usecase.dart          # حالة استخدام المفضلة
├── data/
│   ├── models/
│   │   └── doctor_model.dart                     # نموذج الطبيب
│   ├── datasources/
│   │   ├── doctor_remote_datasource.dart         # مصدر البيانات عن بعد
│   │   └── doctor_local_datasource.dart          # مصدر البيانات المحلي
│   └── repositories/
│       └── doctor_repository_impl.dart           # تنفيذ المستودع
└── presentation/
    ├── bloc/
    │   ├── doctor_listing_bloc.dart              # منطق قائمة الأطباء
    │   ├── doctor_details_bloc.dart              # منطق تفاصيل الطبيب
    │   ├── doctor_listing_event.dart
    │   ├── doctor_listing_state.dart
    │   ├── doctor_details_event.dart
    │   └── doctor_details_state.dart
    └── pages/                                    # صفحات واجهة المستخدم
```

## 🔄 **تدفق الميزة**

### **1. عرض قائمة الأطباء**
```dart
// في DoctorListingScreen
context.read<DoctorListingBloc>().add(const LoadDoctors());

// الاستماع للتغييرات
BlocBuilder<DoctorListingBloc, DoctorListingState>(
  builder: (context, state) {
    if (state is DoctorListingLoading) {
      return const CircularProgressIndicator();
    }

    if (state is DoctorListingLoaded) {
      return ListView.builder(
        itemCount: state.doctors.length,
        itemBuilder: (context, index) {
          return DoctorCard(doctor: state.doctors[index]);
        },
      );
    }

    return const SizedBox.shrink();
  },
)
```

### **2. البحث عن الأطباء**
```dart
// في DoctorListingScreen
final searchController = TextEditingController();

searchController.addListener(() {
  context.read<DoctorListingBloc>().add(
    SearchDoctors(searchController.text),
  );
});
```

### **3. التصفية والفرز**
```dart
// تطبيق التصفية
context.read<DoctorListingBloc>().add(
  FilterDoctors(
    specialty: selectedSpecialty,
    location: selectedLocation,
    minRating: minRating,
    priceRange: priceRange,
  ),
);

// الفرز
context.read<DoctorListingBloc>().add(
  SortDoctors('rating'), // أو 'experience', 'price_low', إلخ
);
```

### **4. عرض تفاصيل الطبيب**
```dart
// في DoctorProfileScreen
context.read<DoctorDetailsBloc>().add(
  LoadDoctorDetails(doctorId),
);

// الاستماع للتغييرات
BlocBuilder<DoctorDetailsBloc, DoctorDetailsState>(
  builder: (context, state) {
    if (state is DoctorDetailsLoaded) {
      return DoctorProfileView(doctor: state.doctor);
    }
    return const SizedBox.shrink();
  },
)
```

### **5. إدارة المفضلة**
```dart
// إضافة/إزالة من المفضلة
context.read<DoctorDetailsBloc>().add(
  ToggleDoctorFavorite(doctorId),
);
```

## 🏭 **Dependency Injection**

### **تسجيل التبعيات في GetIt**

```dart
// في dependency_injection.dart
// Remote DataSource
getIt.registerLazySingleton<DoctorRemoteDataSource>(
  () => DoctorRemoteDataSourceImpl(apiClient: getIt()),
);

// Local DataSource
getIt.registerLazySingleton<DoctorLocalDataSource>(
  () => DoctorLocalDataSourceImpl(sharedPreferences: getIt()),
);

// Repository
getIt.registerLazySingleton<DoctorRepository>(
  () => DoctorRepositoryImpl(
    remoteDataSource: getIt(),
    localDataSource: getIt(),
    networkInfo: getIt(),
  ),
);

// UseCases
getIt.registerLazySingleton(() => GetDoctorsUseCase(getIt()));
getIt.registerLazySingleton(() => GetDoctorDetailsUseCase(getIt()));
getIt.registerLazySingleton(() => SearchDoctorsUseCase(getIt()));
getIt.registerLazySingleton(() => ToggleFavoriteUseCase(getIt()));

// Blocs
getIt.registerFactory(
  () => DoctorListingBloc(
    getDoctorsUseCase: getIt(),
    searchDoctorsUseCase: getIt(),
  ),
);

getIt.registerFactory(
  () => DoctorDetailsBloc(
    getDoctorDetailsUseCase: getIt(),
    toggleFavoriteUseCase: getIt(),
  ),
);
```

## 📱 **استخدام في الواجهة**

### **DoctorListingScreen**

```dart
class DoctorListingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DoctorListingBloc>()..add(const LoadDoctors()),
      child: Scaffold(
        appBar: AppBar(title: const Text('الأطباء')),
        body: Column(
          children: [
            // Search Bar
            TextField(
              onChanged: (query) {
                context.read<DoctorListingBloc>().add(SearchDoctors(query));
              },
              decoration: const InputDecoration(
                hintText: 'البحث عن طبيب...',
              ),
            ),

            // Filter Chips
            Row(
              children: [
                FilterChip(
                  label: const Text('قلب'),
                  onSelected: (selected) {
                    context.read<DoctorListingBloc>().add(
                      const FilterDoctors(specialty: 'قلب'),
                    );
                  },
                ),
                // ... more filter chips
              ],
            ),

            // Doctors List
            Expanded(
              child: BlocBuilder<DoctorListingBloc, DoctorListingState>(
                builder: (context, state) {
                  // Handle different states
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### **DoctorProfileScreen**

```dart
class DoctorProfileScreen extends StatelessWidget {
  final String doctorId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DoctorDetailsBloc>()
        ..add(LoadDoctorDetails(doctorId)),
      child: Scaffold(
        body: BlocBuilder<DoctorDetailsBloc, DoctorDetailsState>(
          builder: (context, state) {
            if (state is DoctorDetailsLoaded) {
              return Column(
                children: [
                  // Doctor Header
                  DoctorHeader(doctor: state.doctor),

                  // Action Buttons
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<DoctorDetailsBloc>().add(const BookAppointment());
                        },
                        child: const Text('حجز موعد'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<DoctorDetailsBloc>().add(const ChatWithDoctor());
                        },
                        child: const Text('المحادثة'),
                      ),
                    ],
                  ),

                  // Doctor Details Tabs
                  TabBarView(
                    children: [
                      AboutTab(doctor: state.doctor),
                      LocationTab(doctor: state.doctor),
                      ReviewsTab(doctor: state.doctor),
                    ],
                  ),
                ],
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
```

## 🔍 **خوارزميات البحث والتصفية**

### **البحث المتقدم**
```dart
// في SearchDoctorsUseCase
@override
Future<Either<Failure, List<Doctor>>> call(String query) async {
  // البحث في الاسم، التخصص، الموقع
  final doctors = await repository.searchDoctors(query.toLowerCase());

  // ترتيب النتائج حسب الصلة
  doctors.sort((a, b) {
    final aScore = _calculateRelevanceScore(a, query);
    final bScore = _calculateRelevanceScore(b, query);
    return bScore.compareTo(aScore);
  });

  return Right(doctors);
}

double _calculateRelevanceScore(Doctor doctor, String query) {
  double score = 0.0;

  // الاسم (أعلى أولوية)
  if (doctor.name.contains(query)) score += 10.0;

  // التخصص
  if (doctor.specialty.contains(query)) score += 5.0;

  // التخصصات الفرعية
  for (final spec in doctor.specializations) {
    if (spec.contains(query)) score += 3.0;
  }

  // الموقع
  if (doctor.location.contains(query)) score += 2.0;

  return score;
}
```

### **التخزين المؤقت الذكي**
```dart
// في DoctorRepositoryImpl
@override
Future<Either<Failure, List<Doctor>>> getDoctors() async {
  // محاولة جلب من الذاكرة المؤقتة أولاً
  final cachedDoctors = await localDataSource.getCachedDoctors();
  if (cachedDoctors != null && cachedDoctors.isNotEmpty) {
    return Right(cachedDoctors);
  }

  // جلب من الخادم إذا لم يكن متوفراً محلياً
  if (await networkInfo.isConnected) {
    final doctors = await remoteDataSource.getDoctors();
    await localDataSource.cacheDoctors(doctors);
    return Right(doctors);
  }

  return const Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
}
```

## 🧪 **اختبار الميزة**

### **اختبار UseCase**

```dart
void main() {
  test('should return list of doctors when get doctors succeeds', () async {
    // Arrange
    when(mockRepository.getDoctors())
        .thenAnswer((_) async => Right(mockDoctors));

    // Act
    final result = await getDoctorsUseCase(const GetDoctorsParams());

    // Assert
    expect(result, Right(mockDoctors));
    verify(mockRepository.getDoctors());
    verifyNoMoreInteractions(mockRepository);
  });
}
```

### **اختبار Bloc**

```dart
blocTest<DoctorListingBloc, DoctorListingState>(
  'emits [DoctorListingLoading, DoctorListingLoaded] when LoadDoctors is added',
  build: () => doctorListingBloc,
  act: (bloc) => bloc.add(const LoadDoctors()),
  expect: () => [
    const DoctorListingLoading(),
    DoctorListingLoaded(mockDoctors),
  ],
);
```

## 🚀 **نصائح التطوير**

1. **التخزين المؤقت**: طبق caching strategy ذكي لتحسين الأداء
2. **البحث**: استخدم debouncing لتقليل عدد الطلبات أثناء الكتابة
3. **التصفية**: اجعل التصفية متعددة المستويات مع إمكانية حفظ الإعدادات
4. **المفضلة**: استخدم local storage للمفضلة وsync مع الخادم
5. **الأداء**: طبق pagination للقوائم الكبيرة
6. **UX**: أضف skeleton loading و empty states

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
- **Appointments**: ربط بحجز المواعيد
- **Chat**: ربط بنظام المحادثة
- **Reviews**: إدارة تقييمات الأطباء
- **Favorites**: إدارة الأطباء المفضلين
