import 'package:intl/intl.dart';

/// Utilidades de formateo de fechas centralizadas.
class DateFormatter {
  DateFormatter._();

  /// Ej: "Tuesday, July 1"
  static String fullDate(DateTime date) {
    return DateFormat('EEEE, MMMM d').format(date);
  }

  /// Ej: "Jul 1, 2026"
  static String shortDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }
}