import 'package:intl/intl.dart';

class CurrencyHelper {
  static String formatRupiah(num number) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return currencyFormatter.format(number);
  }
}
