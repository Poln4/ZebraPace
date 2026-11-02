import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/presentation/screens/insights/widgets/chart_date_axis.dart';

void main() {
  test('label spacing follows the range', () {
    expect(dateLabelStep(5), 1);
    expect(dateLabelStep(14), 2);
    expect(dateLabelStep(30), 3);
    expect(dateLabelStep(90), 12);
  });

  test('no range shows more than about 10 labels', () {
    for (var n = 1; n <= 120; n++) {
      final labels = (n - 1) ~/ dateLabelStep(n) + 1;
      expect(labels, lessThanOrEqualTo(11), reason: '$n days');
    }
  });
}
