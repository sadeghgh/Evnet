import 'dart:io';
import 'dart:math';

class GenRandomNumberHelper {
  static String randomDigits() {
    String currentDateTimeAsStr =
        DateTime.now().microsecondsSinceEpoch.toString();
    String last7digitsOfCurrentDate =
        currentDateTimeAsStr.substring(currentDateTimeAsStr.length - 7);
    return last7digitsOfCurrentDate;
  }
}
