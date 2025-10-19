import 'package:equatable/equatable.dart';

class QuickAction extends Equatable {
  final String id;
  final String title;
  final String arabicTitle;
  final String subtitle;
  final String arabicSubtitle;
  final String iconUrl;
  final String route;
  final String color;
  final bool isEnabled;
  final int priority;

  const QuickAction({
    required this.id,
    required this.title,
    required this.arabicTitle,
    required this.subtitle,
    required this.arabicSubtitle,
    required this.iconUrl,
    required this.route,
    required this.color,
    this.isEnabled = true,
    required this.priority,
  });

  // Sample quick actions for testing
  static List<QuickAction> get sampleActions => [
        const QuickAction(
          id: '1',
          title: 'Book Appointment',
          arabicTitle: 'حجز موعد',
          subtitle: 'Schedule with doctor',
          arabicSubtitle: 'احجز مع طبيب',
          iconUrl: 'assets/icons/calendar.png',
          route: '/book-appointment',
          color: '#4A90E2',
          priority: 1,
        ),
        const QuickAction(
          id: '2',
          title: 'Find Doctor',
          arabicTitle: 'البحث عن طبيب',
          subtitle: 'Search specialists',
          arabicSubtitle: 'ابحث عن متخصصين',
          iconUrl: 'assets/icons/search.png',
          route: '/find-doctor',
          color: '#50C878',
          priority: 2,
        ),
        const QuickAction(
          id: '3',
          title: 'Health Records',
          arabicTitle: 'السجلات الصحية',
          subtitle: 'View your records',
          arabicSubtitle: 'عرض سجلاتك',
          iconUrl: 'assets/icons/records.png',
          route: '/health-records',
          color: '#FF6B6B',
          priority: 3,
        ),
      ];

  @override
  List<Object?> get props => [
        id,
        title,
        arabicTitle,
        subtitle,
        arabicSubtitle,
        iconUrl,
        route,
        color,
        isEnabled,
        priority,
      ];
}
