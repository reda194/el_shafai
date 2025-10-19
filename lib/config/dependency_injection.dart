import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:neurocare_app/core/network/api_client.dart';
import 'package:neurocare_app/core/network/network_info.dart';
import 'package:neurocare_app/core/services/notification_service.dart';
import 'package:neurocare_app/core/services/location_service.dart';
import 'package:neurocare_app/core/services/storage_service.dart';
import 'package:neurocare_app/features/appointment/data/datasources/appointment_remote_datasource.dart';
import 'package:neurocare_app/features/appointment/data/repositories/appointment_repository_impl.dart';
import 'package:neurocare_app/features/appointment/domain/repositories/appointment_repository.dart';
import 'package:neurocare_app/features/appointment/domain/usecases/book_appointment_usecase.dart';
import 'package:neurocare_app/features/appointment/domain/usecases/get_appointments_usecase.dart';
import 'package:neurocare_app/features/appointment/domain/usecases/get_available_time_slots_usecase.dart';
import 'package:neurocare_app/features/appointment/domain/usecases/get_upcoming_appointments_usecase.dart';
import 'package:neurocare_app/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:neurocare_app/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:neurocare_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:neurocare_app/features/chat/domain/usecases/get_chat_rooms_usecase.dart';
import 'package:neurocare_app/features/chat/domain/usecases/get_messages_usecase.dart';
import 'package:neurocare_app/features/chat/domain/usecases/send_message_usecase.dart';
import 'package:neurocare_app/features/payment/data/datasources/payment_remote_datasource.dart';
import 'package:neurocare_app/features/payment/data/repositories/payment_repository_impl.dart';
import 'package:neurocare_app/features/payment/domain/repositories/payment_repository.dart';
import 'package:neurocare_app/features/payment/domain/usecases/add_payment_method_usecase.dart';
import 'package:neurocare_app/features/payment/domain/usecases/get_payment_methods_usecase.dart';
import 'package:neurocare_app/features/payment/domain/usecases/process_payment_usecase.dart';
import 'package:neurocare_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:neurocare_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:neurocare_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:neurocare_app/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:neurocare_app/features/profile/domain/usecases/update_user_profile_usecase.dart';
import 'package:neurocare_app/features/profile/domain/usecases/upload_profile_image_usecase.dart';
import 'package:neurocare_app/features/health_records/data/datasources/health_records_remote_datasource.dart';
import 'package:neurocare_app/features/health_records/data/repositories/health_records_repository_impl.dart';
import 'package:neurocare_app/features/health_records/domain/repositories/health_records_repository.dart';
import 'package:neurocare_app/features/health_records/domain/usecases/get_health_records_usecase.dart';
import 'package:neurocare_app/features/health_records/domain/usecases/upload_health_record_usecase.dart';
import 'package:neurocare_app/features/health_records/domain/usecases/delete_health_record_usecase.dart';
import 'package:neurocare_app/features/health_records/presentation/bloc/health_records_bloc.dart';
import 'package:neurocare_app/features/authentication/presentation/cubit/auth_cubit.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => InternetConnectionChecker());

  // Core Services
  final storageService = StorageService();
  await storageService.initialize();
  getIt.registerSingleton(storageService);

  final notificationService = NotificationService();
  await notificationService.initialize();
  getIt.registerSingleton(notificationService);

  getIt.registerSingleton(LocationService());

  // Network Layer
  getIt.registerLazySingleton(() => ApiClient(getIt()));
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  // Appointment Feature
  // Data sources
  getIt.registerLazySingleton<AppointmentRemoteDataSource>(
    () => AppointmentRemoteDataSourceImpl(dio: getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<AppointmentRepository>(
    () => AppointmentRepositoryImpl(remoteDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetAppointmentsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetUpcomingAppointmentsUseCase(getIt()));
  getIt.registerLazySingleton(() => BookAppointmentUseCase(getIt()));
  getIt.registerLazySingleton(() => GetAvailableTimeSlotsUseCase(getIt()));

  // Chat Feature
  // Data sources
  getIt.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(),
  );

  // Repositories
  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(remoteDataSource: getIt()),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetChatRoomsUseCase(getIt()));
  getIt.registerLazySingleton(() => GetMessagesUseCase(getIt()));
  getIt.registerLazySingleton(() => SendMessageUseCase(getIt()));

  // Payment Feature
  // Data sources
  getIt.registerLazySingleton<PaymentRemoteDataSource>(
    () => PaymentRemoteDataSourceImpl(),
  );

  // Repositories
  getIt.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetPaymentMethodsUseCase(getIt()));
  getIt.registerLazySingleton(() => AddPaymentMethodUseCase(getIt()));
  getIt.registerLazySingleton(() => ProcessPaymentUseCase(getIt()));

  // Profile Feature
  // Data sources
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(dio: getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  // Use cases
  getIt.registerLazySingleton(() => GetUserProfileUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateUserProfileUseCase(getIt()));
  getIt.registerLazySingleton(() => UploadProfileImageUseCase(getIt()));

  // Health Records Feature
  getIt.registerLazySingleton<HealthRecordsRemoteDataSource>(
    () => HealthRecordsRemoteDataSourceImpl(apiClient: getIt()),
  );

  getIt.registerLazySingleton<HealthRecordsRepository>(
    () => HealthRecordsRepositoryImpl(
      remoteDataSource: getIt(),
      networkInfo: getIt(),
    ),
  );

  getIt.registerLazySingleton(() => GetHealthRecordsUseCase(getIt()));
  getIt.registerLazySingleton(() => UploadHealthRecordUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteHealthRecordUseCase(getIt()));

  getIt.registerFactory(() => HealthRecordsBloc(
        getHealthRecordsUseCase: getIt(),
        uploadHealthRecordUseCase: getIt(),
        deleteHealthRecordUseCase: getIt(),
      ));

  // Authentication Feature
  getIt.registerFactory(() => AuthCubit());

  // TODO: Register other features (medications, notifications, doctors) and blocs
}
