import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/domain/models/weight_challenge_entry.dart';
import 'package:zebrapace_app/domain/models/weight_challenge_weigh_in.dart';
import 'package:zebrapace_app/domain/services/challenge_progress_series_builder.dart';

void main() {
  final alice = WeightChallengeEntry(
    userId: 'alice',
    displayName: 'Alice',
    startWeightKg: 100.0,
    currentWeightKg: 95.0,
    updatedAt: DateTime(2026, 1, 10),
  );
  final bob = WeightChallengeEntry(
    userId: 'bob',
    displayName: 'Bob',
    startWeightKg: 80.0,
    currentWeightKg: 82.0,
    updatedAt: DateTime(2026, 1, 10),
  );

  test('normalizes each person against their own starting weight, not a shared scale', () {
    final history = [
      WeightChallengeWeighIn(userId: 'alice', weightKg: 100.0, loggedAt: DateTime(2026, 1, 1)),
      WeightChallengeWeighIn(userId: 'alice', weightKg: 95.0, loggedAt: DateTime(2026, 1, 10)),
      WeightChallengeWeighIn(userId: 'bob', weightKg: 80.0, loggedAt: DateTime(2026, 1, 1)),
      WeightChallengeWeighIn(userId: 'bob', weightKg: 82.0, loggedAt: DateTime(2026, 1, 10)),
    ];

    final series = ChallengeProgressSeriesBuilder.build([alice, bob], history);

    final aliceSeries = series.firstWhere((s) => s.userId == 'alice');
    expect(aliceSeries.points.map((p) => p.percentLost), [0.0, 5.0]);

    final bobSeries = series.firstWhere((s) => s.userId == 'bob');
    // Bob gained weight, so this is negative — the series doesn't clamp.
    expect(bobSeries.points[1].percentLost, closeTo(-2.5, 0.001));
  });

  test('sorts each series by date even if history arrives out of order', () {
    final history = [
      WeightChallengeWeighIn(userId: 'alice', weightKg: 95.0, loggedAt: DateTime(2026, 1, 10)),
      WeightChallengeWeighIn(userId: 'alice', weightKg: 100.0, loggedAt: DateTime(2026, 1, 1)),
    ];

    final series = ChallengeProgressSeriesBuilder.build([alice], history);

    expect(series.single.points.map((p) => p.date), [DateTime(2026, 1, 1), DateTime(2026, 1, 10)]);
  });

  test('a participant with no history yet gets an empty series, not an error', () {
    final series = ChallengeProgressSeriesBuilder.build([alice, bob], const []);

    expect(series, hasLength(2));
    expect(series.every((s) => s.points.isEmpty), isTrue);
  });

  test('one participant\'s weigh-ins never leak into another\'s series', () {
    final history = [
      WeightChallengeWeighIn(userId: 'alice', weightKg: 90.0, loggedAt: DateTime(2026, 1, 5)),
    ];

    final series = ChallengeProgressSeriesBuilder.build([alice, bob], history);

    expect(series.firstWhere((s) => s.userId == 'alice').points, hasLength(1));
    expect(series.firstWhere((s) => s.userId == 'bob').points, isEmpty);
  });
}
