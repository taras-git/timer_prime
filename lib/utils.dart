import 'package:intl/intl.dart';

class TimeUtils {
  static int numOfWeeks(int year) {
    DateTime dec28 = DateTime(year, 12, 28);
    int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
    return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }

  static int weekNumber() {
    final date = DateTime.now();
    int dayOfYear = int.parse(DateFormat("D").format(date));
    int weekOfYear = ((dayOfYear - date.weekday + 10) / 7).floor();
    if (weekOfYear < 1) {
      weekOfYear = numOfWeeks(date.year - 1);
    } else if (weekOfYear > numOfWeeks(date.year)) {
      weekOfYear = 1;
    }
    return weekOfYear;
  }

  static String formattedDate() {
    return DateFormat('E.d.MMM.').format(DateTime.now());
  }

  static String formattedTime() {
    return DateFormat.Hm().format(DateTime.now());
  }
}

class NumberUtils {
  static bool isPrime(int number) {
    if (number <= 1) {
      return false;
    }

    for (int i = 2; i <= number / 2; i++) {
      if (number % i == 0) {
        return false;
      }
    }

    return true;
  }
}
