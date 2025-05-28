import 'package:intl/intl.dart';
class FormatDateTime{
  static String formatDate(DateTime date) => DateFormat('dd/MM/yy').format(date);
}