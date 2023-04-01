import 'package:intl/intl.dart';

String formatValueTypeMoney(num value){
  return NumberFormat.simpleCurrency(locale: 'pt-br', decimalDigits: 2).format(value);
}
