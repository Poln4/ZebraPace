import '../../core/constants/enums.dart';

class SorenessCheck {
  const SorenessCheck({
    required this.id,
    required this.date,
    required this.onset,
    required this.spread,
    required this.trend,
    required this.verdict,
    required this.verdictLabel,
  });

  final String id;
  final String date;
  final SorenessOnset onset;
  final SorenessSpread spread;
  final SorenessTrend trend;
  final String verdict;
  final String verdictLabel;
}
