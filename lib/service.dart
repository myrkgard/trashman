import 'package:trashman/date.dart';

enum TrashType {
  wertstoff,
  restmuell,
  papier,
}

class TrashPair {
  final Date date;
  final TrashType type;

  TrashPair(this.date, this.type);
}

TrashPair _mk(int y, int m, int d, TrashType t) {
  return TrashPair(Date.fromDateTime(DateTime(y, m, d)), t);
}

final List<TrashPair> _db = [
  _mk(2021, 12, 2, TrashType.restmuell),
  _mk(2021, 12, 8, TrashType.wertstoff),
  _mk(2021, 12, 16, TrashType.restmuell),
  _mk(2021, 12, 20, TrashType.papier),
  _mk(2021, 12, 30, TrashType.restmuell),
  //
  _mk(2022, 1, 5, TrashType.wertstoff),
  _mk(2022, 1, 13, TrashType.restmuell),
  _mk(2022, 1, 17, TrashType.papier),
  _mk(2022, 1, 27, TrashType.restmuell),
  //
  _mk(2022, 2, 2, TrashType.wertstoff),
  _mk(2022, 2, 10, TrashType.restmuell),
  _mk(2022, 2, 14, TrashType.papier),
  _mk(2022, 2, 24, TrashType.restmuell),
  //
  _mk(2022, 3, 2, TrashType.wertstoff),
  _mk(2022, 3, 10, TrashType.restmuell),
  _mk(2022, 3, 14, TrashType.papier),
  _mk(2022, 3, 24, TrashType.restmuell),
  _mk(2022, 3, 30, TrashType.wertstoff),
  //
  _mk(2022, 4, 7, TrashType.restmuell),
  _mk(2022, 4, 9, TrashType.papier),
  _mk(2022, 4, 22, TrashType.restmuell),
  _mk(2022, 4, 27, TrashType.wertstoff),
  //
  _mk(2022, 5, 5, TrashType.restmuell),
  _mk(2022, 5, 9, TrashType.papier),
  _mk(2022, 5, 19, TrashType.restmuell),
  _mk(2022, 5, 25, TrashType.wertstoff),
  //
  _mk(2022, 6, 2, TrashType.restmuell),
  _mk(2022, 6, 7, TrashType.papier),
  _mk(2022, 6, 17, TrashType.restmuell),
  _mk(2022, 6, 22, TrashType.wertstoff),
  _mk(2022, 6, 30, TrashType.restmuell),
  //
  _mk(2022, 7, 4, TrashType.papier),
  _mk(2022, 7, 14, TrashType.restmuell),
  _mk(2022, 7, 20, TrashType.wertstoff),
  _mk(2022, 7, 28, TrashType.restmuell),
  //
  _mk(2022, 8, 1, TrashType.papier),
  _mk(2022, 8, 11, TrashType.restmuell),
  _mk(2022, 8, 17, TrashType.wertstoff),
  _mk(2022, 8, 25, TrashType.restmuell),
  _mk(2022, 8, 29, TrashType.papier),
  //
  _mk(2022, 9, 8, TrashType.restmuell),
  _mk(2022, 9, 14, TrashType.wertstoff),
  _mk(2022, 9, 22, TrashType.restmuell),
  _mk(2022, 9, 26, TrashType.papier),
  //
  _mk(2022, 10, 7, TrashType.restmuell),
  _mk(2022, 10, 12, TrashType.wertstoff),
  _mk(2022, 10, 20, TrashType.restmuell),
  _mk(2022, 10, 24, TrashType.papier),
  //
  _mk(2022, 11, 4, TrashType.restmuell),
  _mk(2022, 11, 9, TrashType.wertstoff),
  _mk(2022, 11, 17, TrashType.restmuell),
  _mk(2022, 11, 21, TrashType.papier),
  //
  _mk(2022, 12, 1, TrashType.restmuell),
  _mk(2022, 12, 7, TrashType.wertstoff),
  _mk(2022, 12, 15, TrashType.restmuell),
  _mk(2022, 12, 19, TrashType.papier),
  _mk(2022, 12, 30, TrashType.restmuell),
];

TrashPair? findNext() {
  final n = Date.now();

  for (var i = 0; i < _db.length; ++i) {
    if (_db[i].date.isAfter(n)) {
      return _db[i];
    }
  }
  return null;
}
