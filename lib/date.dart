import 'package:intl/intl.dart' as intl;

const _weekdayNames = <int, String>{
  1: 'monday',
  2: 'tuesday',
  3: 'wednesday',
  4: 'thursday',
  5: 'friday',
  6: 'saturday',
  7: 'sunday',
};

/// A Date object guaranteed to contain a valid date.
class Date {
  final int _year;
  final int _month;
  final int _day;

  int get year => _year;
  int get month => _month;
  int get day => _day;

  /// Returns the weekday as an int.
  /// 1 = monday
  /// 2 = tuesday
  /// 3 = wednesday
  /// 4 = thursday
  /// 5 = friday
  /// 6 = saturday
  /// 7 = sunday
  int weekday() {
    return toDateTime().weekday;
  }

  /// Returns the full name of this date's weekday as a String.
  /// 1 = 'monday'
  /// 2 = 'tuesday'
  /// 3 = 'wednesday'
  /// 4 = 'thursday'
  /// 5 = 'friday'
  /// 6 = 'saturday'
  /// 7 = 'sunday'
  String weekdayName({bool capitalize = false}) {
    var res = _weekdayNames[weekday()]!;
    if (capitalize) {
      res = intl.toBeginningOfSentenceCase(res)!;
    }
    return res;
  }

  /// Returns the shortend name of this date's weekday as a String.
  /// 1 = 'mon'
  /// 2 = 'tue'
  /// 3 = 'wed'
  /// 4 = 'thu'
  /// 5 = 'fri'
  /// 6 = 'sat'
  /// 7 = 'sun'
  /// If capitalize is true returns string with first letter uppercase,
  /// e.g. 'Mon'. If dot is true returns string with '.' appended, e.g. 'mon.',
  /// 'Mon.'.
  String weekdayNameShort({bool capitalize = false, bool dot = false}) {
    var res = weekdayName(capitalize: true).substring(0, 3);
    return dot ? res + '.' : res;
  }

  static Date now() {
    final dt = DateTime.now();
    return Date.fromDateTime(dt);
  }

  static Date yesterday() {
    final dt = DateTime.now();
    return Date.fromDateTime(dt).addDays(-1);
  }

  static Date tomorrow() {
    final dt = DateTime.now();
    return Date.fromDateTime(dt).addDays(1);
  }

  // copy
  Date.from(Date other)
      : _year = other._year,
        _month = other._month,
        _day = other._day;

  Date.fromDateTime(DateTime dt)
      : _year = dt.year,
        _month = dt.month,
        _day = dt.day;

  /// Creates Date object for now. Uses local DateTime.

  /// Creates DateTime object from this. Uses local dateTime.
  DateTime toDateTime() => DateTime(_year, _month, _day);

  /// Creates Date object with days added to this object.
  Date addDays(int days) {
    final dt = toDateTime().add(Duration(days: days));
    return Date.fromDateTime(dt);
  }

  /// Returns true if other this date is before other date.
  bool isBefore(Date other) {
    if (year < other.year) {
      return true;
    } else if (year > other.year) {
      return false;
    } else {
      if (month < other.month) {
        return true;
      } else if (month > other.month) {
        return false;
      } else {
        if (day < other.day) {
          return true;
        } else if (day > other.day) {
          return false;
        } else {
          return false;
        }
      }
    }
  }

  /// Returns true if this date is after other date.
  bool isAfter(Date other) {
    if (year > other.year) {
      return true;
    } else if (year < other.year) {
      return false;
    } else {
      if (month > other.month) {
        return true;
      } else if (month < other.month) {
        return false;
      } else {
        if (day > other.day) {
          return true;
        } else if (day < other.day) {
          return false;
        } else {
          return false;
        }
      }
    }
  }

  /// Returns true if this date is today. Uses local DateTime.
  bool isToday() {
    return this == Date.now();
  }

  /// Returns true if this date is tomorrow. Uses local DateTime.
  bool isTomorrow() {
    return this == Date.now().addDays(1);
  }

  /// Returns true if this date is yesterday. Uses local DateTime.
  bool isYesterday() {
    return this == Date.now().addDays(-1);
  }

  /// Returns this date as ISO 8601 formatted string, e.g. "2021-09-01".
  String toIso8601() {
    var y = _year.toString();
    var m = _month.toString().padLeft(2, '0');
    var d = _day.toString().padLeft(2, '0');
    return y + "-" + m + "-" + d;
  }

  /// Like toIso8601 but with no dashes, e.g. "20210901".
  String toIso8601Short() {
    var y = _year.toString();
    var m = _month.toString().padLeft(2, '0');
    var d = _day.toString().padLeft(2, '0');
    return y + m + d;
  }

  @override
  int get hashCode => _year.hashCode ^ _month.hashCode ^ _day.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Date &&
      other.runtimeType == runtimeType &&
      other.year == year &&
      other.month == month &&
      other.day == day;
}

/// Creates new Date object.
/// Returns null if year/month/day combination is invalid.
Date? tryMakeDate(int year, int month, int day) {
  // DateTime constructor can't throw (obviously).
  // If one passes it an invalid year/month/day combination if returns
  // something stupid. E.g. 2021-09-32 yields 2021-10-02
  var date = Date.fromDateTime(DateTime(year, month, day));
  if (date.year == year && date.month == month && date.day == day) {
    return date;
  } else {
    return null;
  }
}

/// Try to parse ISO 8601 formatted date string, e.g. 2021-09-07.
/// Returns valid Date on success or null on parse error.
Date? tryParseIso8601(String formattedString) {
  // date string: 2021-09-07
  // char pos:    0123456789
  RegExp re = RegExp(r'^\d{4}-\d{2}-\d{2}$');
  if (!re.hasMatch(formattedString)) return null;
  final int? y = int.tryParse(formattedString.substring(0, 4));
  final int? m = int.tryParse(formattedString.substring(5, 7));
  final int? d = int.tryParse(formattedString.substring(8, 10));
  if (y == null || m == null || d == null) return null;
  return tryMakeDate(y, m, d);
}

/// Like tryParseIso8601, but expects formatted string with no dashes, e.g.
/// '20210907'.
Date? tryParseIso8601Short(String formattedString) {
  // date string: 20210907
  // char pos:    01234567
  RegExp re = RegExp(r'^\d{8}$');
  if (!re.hasMatch(formattedString)) return null;
  final int? y = int.tryParse(formattedString.substring(0, 4));
  final int? m = int.tryParse(formattedString.substring(4, 6));
  final int? d = int.tryParse(formattedString.substring(6, 8));
  if (y == null || m == null || d == null) return null;
  return tryMakeDate(y, m, d);
}
