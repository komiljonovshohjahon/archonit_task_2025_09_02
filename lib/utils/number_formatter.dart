import 'package:intl/intl.dart';

extension NumberFormatterHelper on num {
  String toCurrency() {
    final currencyFormatter = NumberFormat.currency(
      locale: Intl.defaultLocale,
      symbol: '\$',
    );
    return currencyFormatter.format(this);
  }
}
