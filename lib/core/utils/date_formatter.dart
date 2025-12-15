import 'package:intl/intl.dart';
import 'package:fashion_app/core/constants/app_constants.dart';

/// Date formatting utilities for the Fashion E-Commerce app
/// Provides comprehensive date/time formatting, parsing, and manipulation
/// Uses the intl package for locale-aware formatting
class DateFormatter {
  // Private constructor to prevent instantiation
  DateFormatter._();

  // ==================== STANDARD FORMATTERS ====================

  /// Format date as "DD/MM/YYYY" (e.g., "15/03/2024")
  static String formatDate(DateTime date) {
    return DateFormat(AppConstants.dateFormat).format(date);
  }

  /// Format date and time as "DD/MM/YYYY HH:mm" (e.g., "15/03/2024 14:30")
  static String formatDateTime(DateTime dateTime) {
    return DateFormat(AppConstants.dateTimeFormat).format(dateTime);
  }

  /// Format time as "HH:mm" (e.g., "14:30")
  static String formatTime(DateTime time) {
    return DateFormat(AppConstants.timeFormat).format(time);
  }

  /// Format date as "MMM yyyy" (e.g., "Mar 2024")
  static String formatMonthYear(DateTime date) {
    return DateFormat(AppConstants.monthYearFormat).format(date);
  }

  /// Format date as "EEEE, dd MMMM yyyy" (e.g., "Friday, 15 March 2024")
  static String formatFullDate(DateTime date) {
    return DateFormat(AppConstants.fullDateFormat).format(date);
  }

  // ==================== CUSTOM FORMATTERS ====================

  /// Format date as "dd MMM yyyy" (e.g., "15 Mar 2024")
  static String formatShortDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  /// Format date as "MMM dd" (e.g., "Mar 15")
  static String formatMonthDay(DateTime date) {
    return DateFormat('MMM dd').format(date);
  }

  /// Format date as "EEEE, dd MMM" (e.g., "Friday, 15 Mar")
  static String formatWeekdayMonthDay(DateTime date) {
    return DateFormat('EEEE, dd MMM').format(date);
  }

  /// Format time with AM/PM (e.g., "02:30 PM")
  static String formatTime12Hour(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  /// Format time with seconds (e.g., "14:30:45")
  static String formatTimeWithSeconds(DateTime time) {
    return DateFormat('HH:mm:ss').format(time);
  }

  /// Format date for order history (e.g., "15 Mar 2024, 14:30")
  static String formatOrderDate(DateTime date) {
    return DateFormat('dd MMM yyyy, HH:mm').format(date);
  }

  /// Format date for chat messages (e.g., "Today, 14:30" or "Yesterday, 09:15" or "15 Mar, 14:30")
  static String formatChatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return 'Today, ${formatTime(date)}';
    } else if (dateOnly == yesterday) {
      return 'Yesterday, ${formatTime(date)}';
    } else if (now.difference(date).inDays < 7) {
      return '${DateFormat('EEEE').format(date)}, ${formatTime(date)}';
    } else {
      return '${formatMonthDay(date)}, ${formatTime(date)}';
    }
  }

  // ==================== RELATIVE TIME FORMATTERS ====================

  /// Format date as relative time ago (e.g., "2 hours ago", "3 days ago")
  /// Returns detailed relative time strings
  static String formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inSeconds > 5) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  /// Format date as short relative time (e.g., "2h ago", "3d ago")
  /// Returns compact relative time strings
  static String formatShortTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '${years}y ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '${months}mo ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'now';
    }
  }

  /// Format date as relative to today (e.g., "Today", "Yesterday", "15 Mar 2024")
  static String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final tomorrow = today.add(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return 'Today';
    } else if (dateOnly == yesterday) {
      return 'Yesterday';
    } else if (dateOnly == tomorrow) {
      return 'Tomorrow';
    } else if (now.difference(date).inDays < 7 && now.difference(date).inDays > 0) {
      return DateFormat('EEEE').format(date); // e.g., "Monday"
    } else {
      return formatShortDate(date);
    }
  }

  // ==================== PARSING ====================

  /// Parse date string in "DD/MM/YYYY" format
  /// Returns null if parsing fails
  static DateTime? parseDate(String dateString) {
    try {
      return DateFormat(AppConstants.dateFormat).parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Parse date time string in "DD/MM/YYYY HH:mm" format
  /// Returns null if parsing fails
  static DateTime? parseDateTime(String dateTimeString) {
    try {
      return DateFormat(AppConstants.dateTimeFormat).parse(dateTimeString);
    } catch (e) {
      return null;
    }
  }

  /// Parse ISO 8601 date string (from API responses)
  /// Examples: "2024-03-15T14:30:00Z", "2024-03-15T14:30:00.000Z"
  /// Returns null if parsing fails
  static DateTime? parseIso8601(String iso8601String) {
    try {
      return DateTime.parse(iso8601String);
    } catch (e) {
      return null;
    }
  }

  /// Parse custom format date string
  /// Returns null if parsing fails
  static DateTime? parseCustomFormat(String dateString, String format) {
    try {
      return DateFormat(format).parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Parse date string with multiple format attempts
  /// Tries common formats until one succeeds
  /// Returns null if all parsing attempts fail
  static DateTime? parseFlexible(String dateString) {
    final formats = [
      AppConstants.dateFormat, // DD/MM/YYYY
      AppConstants.dateTimeFormat, // DD/MM/YYYY HH:mm
      'yyyy-MM-dd', // ISO date
      'yyyy-MM-ddTHH:mm:ss', // ISO datetime without timezone
      'dd MMM yyyy', // 15 Mar 2024
      'MMM dd, yyyy', // Mar 15, 2024
    ];

    for (final format in formats) {
      try {
        return DateFormat(format).parse(dateString);
      } catch (e) {
        continue;
      }
    }

    // Try ISO 8601 parsing as last resort
    return parseIso8601(dateString);
  }

  // ==================== CONVERSION ====================

  /// Convert DateTime to ISO 8601 string (for API requests)
  /// Returns format: "2024-03-15T14:30:00.000Z"
  static String toIso8601(DateTime dateTime) {
    return dateTime.toUtc().toIso8601String();
  }

  /// Convert DateTime to Unix timestamp (seconds since epoch)
  static int toUnixTimestamp(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch ~/ 1000;
  }

  /// Convert Unix timestamp to DateTime
  static DateTime fromUnixTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  /// Convert DateTime to milliseconds since epoch
  static int toMilliseconds(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch;
  }

  /// Convert milliseconds since epoch to DateTime
  static DateTime fromMilliseconds(int milliseconds) {
    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }

  // ==================== DATE COMPARISON ====================

  /// Check if two dates are on the same day
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Check if date is today
  static bool isToday(DateTime date) {
    return isSameDay(date, DateTime.now());
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isSameDay(date, yesterday);
  }

  /// Check if date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return isSameDay(date, tomorrow);
  }

  /// Check if date is in the past
  static bool isPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  /// Check if date is in the future
  static bool isFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  /// Check if two dates are in the same week
  static bool isSameWeek(DateTime date1, DateTime date2) {
    final startOfWeek1 = startOfWeek(date1);
    final startOfWeek2 = startOfWeek(date2);
    return isSameDay(startOfWeek1, startOfWeek2);
  }

  /// Check if two dates are in the same month
  static bool isSameMonth(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month;
  }

  /// Check if two dates are in the same year
  static bool isSameYear(DateTime date1, DateTime date2) {
    return date1.year == date2.year;
  }

  // ==================== DATE MANIPULATION ====================

  /// Get start of day (00:00:00)
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get end of day (23:59:59.999)
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// Get start of week (Monday 00:00:00)
  static DateTime startOfWeek(DateTime date) {
    final daysSinceMonday = date.weekday - 1;
    final monday = date.subtract(Duration(days: daysSinceMonday));
    return startOfDay(monday);
  }

  /// Get end of week (Sunday 23:59:59.999)
  static DateTime endOfWeek(DateTime date) {
    final daysUntilSunday = 7 - date.weekday;
    final sunday = date.add(Duration(days: daysUntilSunday));
    return endOfDay(sunday);
  }

  /// Get start of month (1st day 00:00:00)
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Get end of month (last day 23:59:59.999)
  static DateTime endOfMonth(DateTime date) {
    final nextMonth = DateTime(date.year, date.month + 1, 1);
    final lastDay = nextMonth.subtract(const Duration(days: 1));
    return endOfDay(lastDay);
  }

  /// Get start of year (Jan 1st 00:00:00)
  static DateTime startOfYear(DateTime date) {
    return DateTime(date.year, 1, 1);
  }

  /// Get end of year (Dec 31st 23:59:59.999)
  static DateTime endOfYear(DateTime date) {
    return endOfDay(DateTime(date.year, 12, 31));
  }

  /// Add days to date
  static DateTime addDays(DateTime date, int days) {
    return date.add(Duration(days: days));
  }

  /// Add months to date
  static DateTime addMonths(DateTime date, int months) {
    return DateTime(date.year, date.month + months, date.day);
  }

  /// Add years to date
  static DateTime addYears(DateTime date, int years) {
    return DateTime(date.year + years, date.month, date.day);
  }

  /// Subtract days from date
  static DateTime subtractDays(DateTime date, int days) {
    return date.subtract(Duration(days: days));
  }

  /// Subtract months from date
  static DateTime subtractMonths(DateTime date, int months) {
    return DateTime(date.year, date.month - months, date.day);
  }

  /// Subtract years from date
  static DateTime subtractYears(DateTime date, int years) {
    return DateTime(date.year - years, date.month, date.day);
  }

  // ==================== UTILITY METHODS ====================

  /// Get number of days in a month
  static int daysInMonth(DateTime date) {
    final nextMonth = DateTime(date.year, date.month + 1, 1);
    final lastDay = nextMonth.subtract(const Duration(days: 1));
    return lastDay.day;
  }

  /// Get week number of the year (1-53)
  static int weekOfYear(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysSinceFirstDay = date.difference(firstDayOfYear).inDays;
    return ((daysSinceFirstDay + firstDayOfYear.weekday) / 7).ceil();
  }

  /// Get day of year (1-366)
  static int dayOfYear(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    return date.difference(firstDayOfYear).inDays + 1;
  }

  /// Get age from birthdate
  static int getAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  /// Get difference between two dates in days
  static int daysBetween(DateTime start, DateTime end) {
    final startDate = startOfDay(start);
    final endDate = startOfDay(end);
    return endDate.difference(startDate).inDays;
  }

  /// Check if year is leap year
  static bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  /// Get list of dates between two dates (inclusive)
  static List<DateTime> getDateRange(DateTime start, DateTime end) {
    final dates = <DateTime>[];
    DateTime current = startOfDay(start);
    final endDate = startOfDay(end);

    while (current.isBefore(endDate) || isSameDay(current, endDate)) {
      dates.add(current);
      current = addDays(current, 1);
    }

    return dates;
  }
}
