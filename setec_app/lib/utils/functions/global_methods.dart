import 'package:intl/intl.dart';
class GlobalMethods{
  static String formatDate(DateTime date) => DateFormat('dd/MM/yy').format(date);
}