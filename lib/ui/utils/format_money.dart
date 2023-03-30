import 'package:intl/intl.dart';

String formatValueTypeMoney(double value){
  return NumberFormat.simpleCurrency(locale: 'pt-br', decimalDigits: 2).format(value);
}
