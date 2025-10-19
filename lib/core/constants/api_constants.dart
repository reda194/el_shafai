/// API related constants for the application
class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://api.neurocare.com';
  static const String baseUrlDev = 'https://api-dev.neurocare.com';
  static const String baseUrlStaging = 'https://api-staging.neurocare.com';

  // API Versions
  static const String apiVersion = 'v1';
  static const String apiPath = '/api/$apiVersion';

  // Authentication Endpoints
  static const String login = '$apiPath/auth/login';
  static const String register = '$apiPath/auth/register';
  static const String logout = '$apiPath/auth/logout';
  static const String refreshToken = '$apiPath/auth/refresh';
  static const String forgotPassword = '$apiPath/auth/forgot-password';
  static const String resetPassword = '$apiPath/auth/reset-password';
  static const String verifyOtp = '$apiPath/auth/verify-otp';

  // User Profile Endpoints
  static const String getProfile = '$apiPath/user/profile';
  static const String updateProfile = '$apiPath/user/profile';
  static const String uploadAvatar = '$apiPath/user/avatar';
  static const String changePassword = '$apiPath/user/change-password';

  // Appointment Endpoints
  static const String getAppointments = '$apiPath/appointments';
  static const String getUpcomingAppointments =
      '$apiPath/appointments/upcoming';
  static const String bookAppointment = '$apiPath/appointments/book';
  static const String cancelAppointment = '$apiPath/appointments/{id}/cancel';
  static const String rescheduleAppointment =
      '$apiPath/appointments/{id}/reschedule';
  static const String getAvailableTimeSlots =
      '$apiPath/appointments/available-slots';

  // Doctor Endpoints
  static const String getDoctors = '$apiPath/doctors';
  static const String getDoctorDetails = '$apiPath/doctors/{id}';
  static const String searchDoctors = '$apiPath/doctors/search';
  static const String getDoctorAvailability =
      '$apiPath/doctors/{id}/availability';

  // Chat Endpoints
  static const String getChatRooms = '$apiPath/chat/rooms';
  static const String getChatMessages = '$apiPath/chat/rooms/{roomId}/messages';
  static const String sendMessage = '$apiPath/chat/messages';
  static const String markMessagesRead = '$apiPath/chat/messages/read';

  // Health Records Endpoints
  static const String getHealthRecords = '$apiPath/health-records';
  static const String uploadHealthRecord = '$apiPath/health-records/upload';
  static const String deleteHealthRecord = '$apiPath/health-records/{id}';
  static const String downloadHealthRecord =
      '$apiPath/health-records/{id}/download';

  // Medication Endpoints
  static const String getMedications = '$apiPath/medications';
  static const String addMedication = '$apiPath/medications';
  static const String updateMedication = '$apiPath/medications/{id}';
  static const String deleteMedication = '$apiPath/medications/{id}';
  static const String getMedicationReminders = '$apiPath/medications/reminders';

  // Payment Endpoints
  static const String getPaymentMethods = '$apiPath/payments/methods';
  static const String addPaymentMethod = '$apiPath/payments/methods';
  static const String processPayment = '$apiPath/payments/process';
  static const String getPaymentHistory = '$apiPath/payments/history';

  // Notification Endpoints
  static const String getNotifications = '$apiPath/notifications';
  static const String markNotificationRead = '$apiPath/notifications/{id}/read';
  static const String deleteNotification = '$apiPath/notifications/{id}';

  // Health Tips Endpoints
  static const String getHealthTips = '$apiPath/health-tips';
  static const String getHealthTipDetails = '$apiPath/health-tips/{id}';

  // File Upload Endpoints
  static const String uploadFile = '$apiPath/files/upload';
  static const String deleteFile = '$apiPath/files/{id}';

  // HTTP Headers
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String multipartFormData = 'multipart/form-data';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';

  // Query Parameters
  static const String page = 'page';
  static const String limit = 'limit';
  static const String search = 'search';
  static const String sortBy = 'sort_by';
  static const String sortOrder = 'sort_order';
  static const String dateFrom = 'date_from';
  static const String dateTo = 'date_to';

  // HTTP Status Codes
  static const int ok = 200;
  static const int created = 201;
  static const int noContent = 204;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int conflict = 409;
  static const int internalServerError = 500;

  // Timeout Durations
  static const Duration connectionTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
  static const Duration sendTimeout = Duration(seconds: 10);

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Retry Configuration
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  // Cache Configuration
  static const Duration cacheDuration = Duration(minutes: 5);
  static const String cacheKeyPrefix = 'neurocare_api_cache_';

  // WebSocket URLs
  static const String wsBaseUrl = 'wss://ws.neurocare.com';
  static const String chatWebSocket = '$wsBaseUrl/chat';
  static const String notificationsWebSocket = '$wsBaseUrl/notifications';
}
