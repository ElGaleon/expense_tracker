import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String formatAmount() {
    return NumberFormat.currency(locale: 'it_IT', symbol: '€', decimalDigits: 2).format(this);
  }
}
