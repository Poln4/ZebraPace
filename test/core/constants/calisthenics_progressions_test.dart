import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/core/constants/calisthenics_progressions.dart';

void main() {
  group('meetsGoal', () {
    test('needs targetSets sets each at or above targetValue', () {
      expect(meetsGoal([30, 30, 30], targetSets: 3, targetValue: 30), isTrue);
      expect(meetsGoal([30, 20, 23], targetSets: 3, targetValue: 30), isFalse);
      expect(meetsGoal([30, 31, 40, 10], targetSets: 3, targetValue: 30), isTrue,
          reason: 'an extra, weaker set does not undo a met goal');
      expect(meetsGoal([90], targetSets: 3, targetValue: 30), isFalse,
          reason: 'one big set is not three sets');
    });
  });

  group('goalProgress', () {
    test('credits the best targetSets sets, each capped at the target', () {
      expect(goalProgress([30, 20, 23], targetSets: 3, targetValue: 30), closeTo(73 / 90, 1e-9));
      expect(goalProgress([60, 60, 60], targetSets: 3, targetValue: 30), 1.0);
      expect(goalProgress([10, 50], targetSets: 1, targetValue: 30), 1.0);
      expect(goalProgress([], targetSets: 3, targetValue: 30), 0.0);
    });
  });
}
