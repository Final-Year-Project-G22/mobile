import 'package:intl/intl.dart';

class NumberFormatters {
  NumberFormatters._();

  static final _decimal = NumberFormat('#,##0.##');
  static final _currency = NumberFormat.currency(symbol: r'$', decimalDigits: 2);
  static final _percent = NumberFormat.percentPattern();
  static final _currencyCompact = NumberFormat.compactCurrency(symbol: r'$');

  static String decimal(num value) => _decimal.format(value);
  static String currency(num value) => _currency.format(value);
  static String currencyCompact(num value) => _currencyCompact.format(value);
  static String percent(num value) => _percent.format(value);

  static String custom(num value, String pattern) {
    return NumberFormat(pattern).format(value);
  }

  static String phone(String phone) {
    if (phone.length == 10) {
      return '(${phone.substring(0, 3)}) ${phone.substring(3, 6)}-${phone.substring(6)}';
    }
    return phone;
  }

  static String creditCard(String card) {
    if (card.length >= 4) {
      return '•••• •••• •••• ${card.substring(card.length - 4)}';
    }
    return card;
  }
}
