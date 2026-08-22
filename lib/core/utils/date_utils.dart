/// Local-time date-only bucketing. Every "day" in this app is keyed by the
/// device's local calendar date, matching app.py's timezone-naive behavior —
/// deliberately kept simple; changing timezones mid-day can shift which "day"
/// an entry lands in, same limitation as the Python original.
library;

const String dateKeyFormat = 'yyyy-MM-dd';

String dateKey(DateTime date) {
  final local = date.toLocal();
  final y = local.year.toString().padLeft(4, '0');
  final m = local.month.toString().padLeft(2, '0');
  final d = local.day.toString().padLeft(2, '0');
  return '$y-$m-$d';
}

String todayKey() => dateKey(DateTime.now());

DateTime dateFromKey(String key) {
  final parts = key.split('-');
  return DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
}

String timeKey(DateTime dateTime) {
  final local = dateTime.toLocal();
  final h = local.hour.toString().padLeft(2, '0');
  final min = local.minute.toString().padLeft(2, '0');
  return '$h:$min';
}

String nowIso() => DateTime.now().toUtc().toIso8601String();

List<String> dateKeysBetween(String start, String end) {
  final startDate = dateFromKey(start);
  final endDate = dateFromKey(end);
  final dates = <String>[];
  for (var d = startDate; !d.isAfter(endDate); d = d.add(const Duration(days: 1))) {
    dates.add(dateKey(d));
  }
  return dates;
}
