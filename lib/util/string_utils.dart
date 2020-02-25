import 'package:intl/intl.dart';

class StringUtils {
  static String formatPrice(double price) {
    var numberFormat =
        NumberFormat.simpleCurrency(locale: 'pt_BR', decimalDigits: 2);

    return numberFormat.format(price);
  }

  static String getFirstName(String fullName) {
    return fullName.split(' ')[0];
  }
}
