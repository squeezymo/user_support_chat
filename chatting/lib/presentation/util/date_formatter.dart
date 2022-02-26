import 'package:intl/intl.dart';

class DateTimeVerbalizer {

  const DateTimeVerbalizer();

  static String verbalize(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime localDateTime = dateTime.toLocal();

    String roughTimeString = DateFormat('HH:mm').format(dateTime);

    if (localDateTime.day == now.day && localDateTime.month == now.month && localDateTime.year == now.year) {
      return roughTimeString;
    }

    DateTime yesterday = now.subtract(const Duration(days: 1));

    if (localDateTime.day == yesterday.day && localDateTime.month == now.month && localDateTime.year == now.year) {
      return "вчера $roughTimeString"; // TODO Localize
    }

    if (now.difference(localDateTime).inDays < 4) {
      String weekday = DateFormat('EEEE').format(localDateTime);

      return '$weekday, $roughTimeString';
    }

    return DateFormat('dd.MM HH:mm').format(dateTime);
  }

}
