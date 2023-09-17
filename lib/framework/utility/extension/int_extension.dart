extension IntExtension on int {

  DateTime milliSecondsToDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }
}