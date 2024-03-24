import 'package:intl/intl.dart';

/// Class used to perform text formatting operations/
class TextFormatting {
  /// Formats currency to es_CO
  static String getFormattedCurrency(num value, {int decimals = 0}) {
    NumberFormat _formatCurrency = NumberFormat.currency(
        decimalDigits: decimals, locale: 'es_CO', symbol: '\$');
    if (value.floor() == value.toInt()) {
      _formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 0);
    }
    return _formatCurrency.format(value).replaceAll('\$', '\$ ');
  }
}
