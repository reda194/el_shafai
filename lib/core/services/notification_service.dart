import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

/// Notification service for handling local notifications
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initialize the notification service
  Future<void> initialize() async {
    // Request notification permissions
    await _requestPermissions();

    // Initialize notification settings
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  /// Request notification permissions
  Future<void> _requestPermissions() async {
    // Request notification permission
    final status = await Permission.notification.request();
    if (status.isDenied) {
      // Handle denied permission
    }
  }

  /// Show immediate notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    NotificationDetails? notificationDetails,
  }) async {
    final details = notificationDetails ??
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'general_channel',
            'General Notifications',
            channelDescription: 'General app notifications',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: true,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        );

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }

  /// Schedule a notification
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
    NotificationDetails? notificationDetails,
  }) async {
    final details = notificationDetails ??
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'scheduled_channel',
            'Scheduled Notifications',
            channelDescription: 'Scheduled notifications',
            importance: Importance.max,
            priority: Priority.high,
            showWhen: true,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  /// Schedule medication reminder notification
  Future<void> scheduleMedicationReminder({
    required int id,
    required String medicationName,
    required String dosage,
    required DateTime scheduledTime,
    required List<DateTime> reminderTimes,
  }) async {
    for (final reminderTime in reminderTimes) {
      final scheduledDate = DateTime(
        reminderTime.year,
        reminderTime.month,
        reminderTime.day,
        scheduledTime.hour,
        scheduledTime.minute,
      );

      if (scheduledDate.isAfter(DateTime.now())) {
        await scheduleNotification(
          id: id + reminderTimes.indexOf(reminderTime),
          title: 'Medication Reminder',
          body: 'Time to take $medicationName - $dosage',
          scheduledDate: scheduledDate,
          payload: 'medication_$id',
        );
      }
    }
  }

  /// Schedule appointment reminder notification
  Future<void> scheduleAppointmentReminder({
    required int id,
    required String doctorName,
    required String appointmentType,
    required DateTime appointmentTime,
    int minutesBefore = 30,
  }) async {
    final reminderTime =
        appointmentTime.subtract(Duration(minutes: minutesBefore));

    if (reminderTime.isAfter(DateTime.now())) {
      await scheduleNotification(
        id: id,
        title: 'Appointment Reminder',
        body:
            'You have an appointment with Dr. $doctorName for $appointmentType in $minutesBefore minutes',
        scheduledDate: reminderTime,
        payload: 'appointment_$id',
      );
    }
  }

  /// Cancel a specific notification
  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  /// Get pending notification requests
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null) {
      // Handle notification tap based on payload
      if (payload.startsWith('medication_')) {
        // Navigate to medication screen
        _handleMedicationNotification(payload);
      } else if (payload.startsWith('appointment_')) {
        // Navigate to appointment screen
        _handleAppointmentNotification(payload);
      }
    }
  }

  /// Handle medication notification tap
  void _handleMedicationNotification(String payload) {
    // final medicationId = payload.replaceFirst('medication_', '');
    // Navigate to medication details or mark as taken
    // This would typically use a navigation service or state management
  }

  /// Handle appointment notification tap
  void _handleAppointmentNotification(String payload) {
    // final appointmentId = payload.replaceFirst('appointment_', '');
    // Navigate to appointment details
    // This would typically use a navigation service or state management
  }

  /// Create notification channel for Android
  Future<void> createNotificationChannel({
    required String id,
    required String name,
    required String description,
    Importance importance = Importance.max,
    Priority priority = Priority.high,
  }) async {
    final androidPlugin = AndroidFlutterLocalNotificationsPlugin();
    await androidPlugin.createNotificationChannel(
      AndroidNotificationChannel(
        id,
        name,
        description: description,
        importance: importance,
      ),
    );
  }
}
