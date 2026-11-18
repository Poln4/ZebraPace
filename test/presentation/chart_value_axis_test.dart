import 'package:flutter_test/flutter_test.dart';
import 'package:zebrapace_app/presentation/screens/insights/widgets/chart_value_axis.dart';

void main() {
  test('uses only the decimals the grid spacing needs', () {
    expect(axisNumber(62.5, 0.5), '62.5');
    expect(axisNumber(62, 0.5), '62');
    expect(axisNumber(62.25, 0.25), '62.25');
    expect(axisNumber(70, 5), '70');
    expect(axisNumber(61.733333, 2), '62');
  });

  test('shortens thousands', () {
    expect(axisNumber(1500, 500), '1.5k');
    expect(axisNumber(2000, 500), '2k');
    expect(axisNumber(12000, 2000), '12k');
  });
}
