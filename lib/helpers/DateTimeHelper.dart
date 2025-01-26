class DateTimeHelper {
  DateTime? _dateTime;

  DateTimeHelper([this._dateTime]);

  void setDateTime(DateTime dateTime) {
    _dateTime = dateTime;
  }

  DateTime now() {
    return _dateTime ?? DateTime.now();
  }
}