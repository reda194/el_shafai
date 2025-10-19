import 'package:intl/intl.dart';

/// Date formatting utilities for consistent date display across the app
class DateFormatter {
  // Common date formats
  static const String _displayDateFormat = 'dd/MM/yyyy';
  static const String _displayTimeFormat = 'HH:mm';
  static const String _displayDateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String _apiDateFormat = 'yyyy-MM-dd';
  static const String _apiDateTimeFormat = 'yyyy-MM-ddTHH:mm:ssZ';

  // DateFormat instances for reuse
  static final DateFormat _displayDateFormatter =
      DateFormat(_displayDateFormat);
  static final DateFormat _displayTimeFormatter =
      DateFormat(_displayTimeFormat);
  static final DateFormat _displayDateTimeFormatter =
      DateFormat(_displayDateTimeFormat);
  static final DateFormat _apiDateFormatter = DateFormat(_apiDateFormat);
  static final DateFormat _apiDateTimeFormatter =
      DateFormat(_apiDateTimeFormat);

  /// Format date for display (dd/MM/yyyy)
  static String formatDate(DateTime date) {
    return _displayDateFormatter.format(date);
  }

  /// Format time for display (HH:mm)
  static String formatTime(DateTime date) {
    return _displayTimeFormatter.format(date);
  }

  /// Format date and time for display (dd/MM/yyyy HH:mm)
  static String formatDateTime(DateTime date) {
    return _displayDateTimeFormatter.format(date);
  }

  /// Format date for API requests (yyyy-MM-dd)
  static String formatDateForApi(DateTime date) {
    return _apiDateFormatter.format(date);
  }

  /// Format date and time for API requests (yyyy-MM-ddTHH:mm:ssZ)
  static String formatDateTimeForApi(DateTime date) {
    return _apiDateTimeFormatter.format(date);
  }

  /// Parse date from API response (yyyy-MM-dd)
  static DateTime? parseApiDate(String dateString) {
    try {
      return _apiDateFormatter.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Parse date and time from API response (yyyy-MM-ddTHH:mm:ssZ)
  static DateTime? parseApiDateTime(String dateTimeString) {
    try {
      return _apiDateTimeFormatter.parse(dateTimeString);
    } catch (e) {
      return null;
    }
  }

  /// Format relative time (e.g., "2 hours ago", "yesterday", "in 3 days")
  static String formatRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        } else {
          return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
        }
      } else {
        return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
      }
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months == 1 ? '' : 's'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years year${years == 1 ? '' : 's'} ago';
    }
  }

  /// Format time duration in human readable format
  static String formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays} day${duration.inDays == 1 ? '' : 's'}';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} hour${duration.inHours == 1 ? '' : 's'}';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} minute${duration.inMinutes == 1 ? '' : 's'}';
    } else {
      return '${duration.inSeconds} second${duration.inSeconds == 1 ? '' : 's'}';
    }
  }

  /// Get day name from date
  static String getDayName(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  /// Get short day name from date
  static String getShortDayName(DateTime date) {
    return DateFormat('EEE').format(date);
  }

  /// Get month name from date
  static String getMonthName(DateTime date) {
    return DateFormat('MMMM').format(date);
  }

  /// Get short month name from date
  static String getShortMonthName(DateTime date) {
    return DateFormat('MMM').format(date);
  }

  /// Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// Check if date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  /// Get start of day
  static DateTime getStartOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get end of day
  static DateTime getEndOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// Get week start (Monday)
  static DateTime getWeekStart(DateTime date) {
    final dayOfWeek = date.weekday;
    final daysToSubtract = dayOfWeek - 1; // Monday = 1
    return date.subtract(Duration(days: daysToSubtract));
  }

  /// Get week end (Sunday)
  static DateTime getWeekEnd(DateTime date) {
    final dayOfWeek = date.weekday;
    final daysToAdd = 7 - dayOfWeek; // Sunday = 7
    return date.add(Duration(days: daysToAdd));
  }

  /// Get month start
  static DateTime getMonthStart(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Get month end
  static DateTime getMonthEnd(DateTime date) {
    final nextMonth = DateTime(date.year, date.month + 1, 1);
    return nextMonth.subtract(const Duration(days: 1));
  }
}
