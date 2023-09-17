import 'package:restaurant_menu_poc/ui/utils/const/app_constants.dart';

extension StringExtension on String {
  String get capsFirstLetterOfSentence =>
      '${this[0].toUpperCase()}${substring(1)}';

  String get allInCaps => toUpperCase();

  String get capitalizeFirstLetterOfSentence =>
      split(' ').map((str) => str.capsFirstLetterOfSentence).join(' ');

  String get removeWhiteSpace => replaceAll(' ', '');

  bool get isEmptyString => removeWhiteSpace.isEmpty;

  String get encodedURL => Uri.encodeFull(this);

  bool get isTrue => (this == '1' ||
      toLowerCase() == 't' ||
      toLowerCase() == 'true' ||
      toLowerCase() == 'y' ||
      toLowerCase() == 'yes');



  ///Validations
  bool isPasswordValid() {
    if (length >= 8 && length <= 15) {
      return true;
    } else {
      return false;
    }
  }

  bool isPhoneNumberValid() {
    if (length > 0 && length == 10) {
      return true;
    } else {
      return false;
    }
  }

  bool isEmailValid() {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    // RegExp regex = new RegExp(pattern);
    RegExp regex = RegExp(pattern.toString());
    if (!(regex.hasMatch(this))) {
      return false;
    } else {
      return true;
    }
  }

  bool isWebsiteValid() {
    final urlRegExp = RegExp(r'((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?');

    if (!(urlRegExp.hasMatch(this))) {
      return false;
    } else {
      return true;
    }
  }

  bool isToday(DateTime dateTime) {
    if (dateTime.day == kToday.day &&
        dateTime.month == kToday.month &&
        dateTime.year == kToday.year) {
      return true;
    }
    return false;
  }

  /// Checks if two DateTime objects are the same day.
  /// Returns `false` if either of them is null.
  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }

    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

}
